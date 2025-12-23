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
//        tableView.delegate = self
//        tableView.dataSource = self
        
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

