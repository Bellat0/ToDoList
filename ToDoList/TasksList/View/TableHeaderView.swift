//
//  TableHeaderView.swift
//  ToDoList
//
//  Created by Maxim Tvilinev on 23.12.2025.
//

import UIKit
import SnapKit

final class TableHeaderView: UIView {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    let searchField = UITextField()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        backgroundColor = AppColors.appBackground
        
        addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 34, weight: .bold)
        titleLabel.text = "Задачи"
        titleLabel.textColor = AppColors.primaryText
        
        addSubview(searchField)
        searchField.backgroundColor = AppColors.containerBackground
        searchField.layer.cornerRadius = 10
        searchField.placeholder = "  Search"
        searchField.clearButtonMode = .whileEditing
        
        let searchImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchImageView.tintColor = .gray
        let searchIconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        searchImageView.frame = CGRect(x: 8, y: 0, width: 24, height: 24)
        searchIconContainer.addSubview(searchImageView)
        searchField.leftView = searchIconContainer
        searchField.leftViewMode = .always
        
        let micImageView = UIImageView(image: UIImage(systemName: "microphone.fill"))
        micImageView.tintColor = .gray
        let micIconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        micImageView.frame = CGRect(x: -8, y: 0, width: 24, height: 24)
        micIconContainer.addSubview(micImageView)
        searchField.rightView = micIconContainer
        searchField.rightViewMode = .always
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
        }
        
        searchField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
