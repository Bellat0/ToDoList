//
//  TaskDetailsViewController.swift
//  ToDoList
//
//  Created by Maxim Tvilinev on 23.12.2025.
//

import UIKit
import SnapKit

final class TaskDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let titleTextView = UITextView()
    private let dateLabel = UILabel()
    private let descriptionTextView = UITextView()
    
    private let task: TaskModel?
    
    var onSave: ((TaskModel) -> Void)?
    
    // MARK: - Init
    
    init(task: TaskModel?) {
        self.task = task
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        configure()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            saveTaskIfNeeded()
        }
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        view.backgroundColor = AppColors.appBackground
        
        view.addSubview(titleTextView)
        titleTextView.font = .systemFont(ofSize: 32, weight: .bold)
        titleTextView.textColor = AppColors.primaryText
        titleTextView.backgroundColor = .clear
        titleTextView.isScrollEnabled = false
        titleTextView.textContainerInset = .zero
        titleTextView.textContainer.lineFragmentPadding = 0
        titleTextView.returnKeyType = .done
        
        view.addSubview(dateLabel)
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = AppColors.secondaryText
        
        view.addSubview(descriptionTextView)
        descriptionTextView.font = .systemFont(ofSize: 17)
        descriptionTextView.textColor = AppColors.primaryText
        descriptionTextView.backgroundColor = .clear
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.textContainerInset = .zero
        descriptionTextView.textContainer.lineFragmentPadding = 0
    }
    
    private func setupConstraints() {
        titleTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualTo(view.keyboardLayoutGuide.snp.top).offset(-16)
        }
    }
    
    private func format(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: date)
    }
    
    private func saveTaskIfNeeded() {

        let title = titleTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        let description = descriptionTextView.text

        guard !title.isEmpty else { return }

        let newTask = TaskModel(
            isCompleted: task?.isCompleted ?? false,
            title: title,
            description: description,
            date: task?.date ?? Date()
        )

        onSave?(newTask)
    }
    
    // MARK: - Configure
    
    private func configure() {
        guard let task else { return }
        
        titleTextView.text = task.title
        descriptionTextView.text = task.description
        dateLabel.text = format(task.date)
    }
}
