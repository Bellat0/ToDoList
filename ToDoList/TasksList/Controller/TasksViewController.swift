//
//  ViewController.swift
//  ToDoList
//
//  Created by Maxim Tvilinev on 23.12.2025.
//

import UIKit
import SnapKit

class TasksViewController: UIViewController {

    // MARK: - Properties
    
    // MARK:  UI
    
    private(set) var tableView = UITableView()
    
    private let bottomView = BottomView()
    lazy var tableHeaderView: TableHeaderView = {
        return TableHeaderView(frame: .zero)
    }()
    
    // MARK: Data
    
    var tasks = [
        TaskModel(title: "Уборка в квартире", description: "Сделать уборку в квартире", date: .now),
        TaskModel(title: "Спорт", description: "Купить абонемент в качалку", date: .now),
        TaskModel(title: "Вечерний отдых", description: "Почитать комиксы", date: .now),
        TaskModel(title: "Английский", description: "Скачать дуолинго", date: .now),
        TaskModel(title: "Английский", description: "Скачать дуолинго", date: .now)
    ]
    
    var filteredTasks = [TaskModel]()
    
    // MARK: State
    
    var isSearching = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredTasks = tasks
        
        setupViews()
        setupConstraints()
        setupTableView()
        
        setupBottomNumberLabel()
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
}

