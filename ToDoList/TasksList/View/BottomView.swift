//
//  BottomView.swift
//  ToDoList
//
//  Created by Maxim Tvilinev on 23.12.2025.
//

import UIKit
import SnapKit

final class BottomView: UIView {
    
    // MARK: - Completion handler
    
    var addTaskCompletion: (() -> Void)?
    
    // MARK: - Properties
    
    private let tasksNumberLabel = UILabel()
    private let taskNameLabel = UILabel()
    private let tasksStackView = UIStackView()
    
    private let addTaskButton = UIButton()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = AppColors.containerBackground
        
        addSubview(tasksStackView)
        addSubview(addTaskButton)
        
        addTaskButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        addTaskButton.tintColor = AppColors.accent
        
        addTaskButton.addTarget(self, action: #selector(addNewTask), for: .touchUpInside)
        
        tasksStackView.addArrangedSubview(tasksNumberLabel)
        tasksStackView.addArrangedSubview(taskNameLabel)
        tasksStackView.axis = .horizontal
        tasksStackView.spacing = 1
        
        tasksNumberLabel.text = "7"
        taskNameLabel.text = "Задач"
        
        [taskNameLabel, tasksNumberLabel].forEach { label in
            label.font = .systemFont(ofSize: 11)
            label.textColor = AppColors.primaryText
        }
    }
    
    private func setupConstraints() {
        tasksStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
        addTaskButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
    
    // MARK: - Action
    
    @objc func addNewTask() {
        addTaskCompletion?()
    }
    
    // MARK: - Configure
    
    func configure(number: String) {
        self.tasksNumberLabel.text = number
    }
}
