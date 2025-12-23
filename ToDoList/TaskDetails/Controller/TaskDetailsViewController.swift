//
//  TaskDetailsViewController.swift
//  ToDoList
//
//  Created by Maxim Tvilinev on 23.12.2025.
//

import UIKit
import SnapKit

class TaskDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let titleTextField = UITextField()
    private let dateLabel = UILabel()
    private let descriptionTextView = UITextView()
    
    // MARK: - Init
    
    init(task: TaskModel) {
        self.titleTextField.text = task.title
        self.dateLabel.text = task.date.description
        self.descriptionTextView.text = task.description
        
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
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        view.backgroundColor = AppColors.appBackground
        
        view.addSubview(titleTextField)
        titleTextField.font = .systemFont(ofSize: 32, weight: .bold)
        titleTextField.textColor = AppColors.primaryText
        titleTextField.borderStyle = .none
        titleTextField.returnKeyType = .done
        
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
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualTo(view.keyboardLayoutGuide.snp.top).offset(-16)
        }
    }
}
