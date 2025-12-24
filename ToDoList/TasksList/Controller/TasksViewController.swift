//
//  ViewController.swift
//  ToDoList
//
//  Created by Maxim Tvilinev on 23.12.2025.
//

import UIKit
import SnapKit
import CoreData

class TasksViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK:  UI
    
    private(set) var tableView = UITableView()
    
    private let bottomView = BottomView()
    lazy var tableHeaderView: TableHeaderView = {
        return TableHeaderView(frame: .zero)
    }()
    
    // MARK: Data
    
    var tasks = [TaskModel]()
    
    var filteredTasks = [TaskModel]()
    
    private let repository = TasksRepository()
    
    // MARK: State
    
    var isSearching = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredTasks = tasks
        
        setupViews()
        setupConstraints()
        setupTableView()
        setupBottomActions()
        
        loadInitialTodosIfNeeded()
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        view.backgroundColor = AppColors.appBackground
        
        view.addSubview(tableView)
        tableView.backgroundColor = AppColors.appBackground
        tableView.showsVerticalScrollIndicator = false
        
        view.addSubview(bottomView)
        bottomView.backgroundColor = AppColors.containerBackground
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(
            TaskCell.self,
            forCellReuseIdentifier: TaskCell.ID)
        
        tableHeaderView.searchField.delegate = self
        
        setupTableHeaderView()
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(49+34)
        }
    }
    
    private func setupBottomNumberLabel() {
        bottomView.configure(number: String(tasks.count))
    }
    
    private func setupTableHeaderView() {
        tableView.tableHeaderView = tableHeaderView
        tableHeaderView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        tableHeaderView.layoutIfNeeded()
        tableView.tableHeaderView = tableHeaderView
    }
    
    private func setupBottomActions() {
        bottomView.addTaskCompletion = { [weak self] in
            guard let self else { return }
            
            let vc = TaskDetailsViewController(task: nil)
            
            vc.onSave = { [weak self] newTask in
                guard let self else { return }
                
                let context = CoreDataManager.shared.context
                
                let entity = TaskEntity(context: context)
                entity.id = newTask.id
                entity.title = newTask.title
                entity.taskDescription = newTask.description
                entity.date = newTask.date
                entity.isCompleted = newTask.isCompleted
                
                CoreDataManager.shared.saveContext()
                
                self.tasks.insert(newTask, at: 0)
                self.filteredTasks = self.tasks
                self.tableView.reloadData()
                self.setupBottomNumberLabel()
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func loadTasks() {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: false)
        ]
        
        let entities = try? CoreDataManager.shared.context.fetch(request)
        self.tasks = entities?.map { $0.toModel() } ?? []
        self.filteredTasks = tasks
    }
    
    func updateTaskInCoreData(_ task: TaskModel) {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        
        if let entity = try? CoreDataManager.shared.context.fetch(request).first {
            entity.title = task.title
            entity.taskDescription = task.description
            entity.date = task.date
            entity.isCompleted = task.isCompleted
            
            CoreDataManager.shared.saveContext()
        }
    }
    
    // MARK: - Actions
    
    func presentShareController(for indexPath: IndexPath) {
        let task = filteredTasks[indexPath.row]
        
        let text = """
        \(task.title ?? "")
        
        \(task.description ?? "")
        """
        
        let vc = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        
        present(vc, animated: true)
    }
    
    func loadFromCoreData() {
        tasks = repository.fetchTasks()
        tableView.reloadData()
    }
    
    func loadInitialTodosIfNeeded() {
        let hasLoaded = UserDefaults.standard.bool(forKey: AppLaunchState.hasLoadedInitialTodos)
        
        
        if hasLoaded || !repository.isEmpty() {
            loadTasks()
            tableView.reloadData()
            setupBottomNumberLabel()
            return
        }
        
        NetworkService.shared.fetchData { [weak self] result in
            switch result {
            case .success(let todos):
                let models = todos.map { $0.toTaskModel() }
                
                
                self?.repository.saveInitialTasks(models) {
                    UserDefaults.standard.set(true, forKey: AppLaunchState.hasLoadedInitialTodos)
                    
                    
                    self?.loadTasks()
                    self?.tableView.reloadData()
                    self?.setupBottomNumberLabel()
                }
                
            case .failure(let error):
                print("Ошибка сети: \(error)")
            }
        }
    }
}

