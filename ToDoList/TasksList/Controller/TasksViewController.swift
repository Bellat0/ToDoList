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
    
    private(set) var tableView = UITableView()
    
//    private let bottomView = BottomView()
//    lazy var tableHeaderView: TableHeaderView = {
//        return TableHeaderView(frame: .zero)
//    }()
    
    var tasks = [
        TaskModel(title: "Уборка в квартире", description: "Сделать уборку в квартире",date: .now),
        TaskModel(title: "Спорт", description: "Купить абонемент в качалку",date: .now),
        TaskModel(title: "Вечерний отдых", description: "Почитать комиксы",date: .now),
        TaskModel(title: "Английский", description: "Скачать дуолинго",date: .now)
    ]
    
    // MARK: - Init
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupTableView()
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        view.backgroundColor = AppColors.appBackground
        
        view.addSubview(tableView)
        tableView.backgroundColor = AppColors.appBackground
        tableView.showsVerticalScrollIndicator = false
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(
            TaskCell.self,
            forCellReuseIdentifier: TaskCell.ID)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

