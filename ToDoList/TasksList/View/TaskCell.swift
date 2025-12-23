//
//  TaskCell.swift
//  ToDoList
//
//  Created by Maxim Tvilinev on 23.12.2025.
//

import UIKit
import SnapKit

final class TaskCell: UITableViewCell {
    static let ID = "TaskCell"
    
    // MARK: - Properties
    
    var isCompleted: Bool = false
    
    private let statusButton = UIButton()
    
    private let contentStackView = UIStackView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dateLabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        selectionStyle = .none
        
        contentView.addSubview(statusButton)
        statusButton.setImage(UIImage(systemName: "circle"), for: .normal)
        statusButton.tintColor = AppColors.secondaryText
        
        statusButton.addTarget(self, action: #selector(statusButtonTapped), for: .touchUpInside)
        
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
        contentStackView.addArrangedSubview(dateLabel)
        contentStackView.axis = .vertical
        contentStackView.alignment = .leading
        contentStackView.spacing = 8
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = AppColors.primaryText
        
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = AppColors.primaryText
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = AppColors.primaryText
        dateLabel.layer.opacity = 0.5
    }
    
    private func setupConstraints() {
        statusButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(24)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.leading.equalTo(statusButton.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Action
    
    @objc func statusButtonTapped() {
        isCompleted.toggle()
        updateUI(completed: isCompleted)
    }
    
    private func updateUI(completed: Bool) {
        let textColor = completed ? 0.5 : 1.0
        titleLabel.layer.opacity = Float(textColor)
        descriptionLabel.layer.opacity = Float(textColor)
        
        if completed {
            
            let attributeString = NSAttributedString(
                string: titleLabel.text ?? "",
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            titleLabel.attributedText = attributeString
            statusButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            statusButton.tintColor = AppColors.accent
        } else {
            let plainString = titleLabel.text ?? ""
            titleLabel.attributedText = nil
            titleLabel.text = plainString
            statusButton.setImage(UIImage(systemName: "circle"), for: .normal)
            statusButton.tintColor = AppColors.secondaryText
        }
    }
    
    private func dateFormatter() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.dateFormat = "dd/MM/yy"
        let dateString = formatter.string(from: Date())
        
        return dateString
    }
    
    // MARK: - Configure
    
    func configure(with task: TaskModel) {
        self.titleLabel.text = task.title
        self.descriptionLabel.text = task.description
        self.dateLabel.text = dateFormatter()

       
        updateUI(completed: isCompleted)
    }
    
}
