//
//  TasksViewController+TextField.swift
//  ToDoList
//
//  Created by Maxim Tvilinev on 23.12.2025.
//

import UIKit

extension TasksViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let searchText = textField.text?.lowercased() else { return }
        
        if searchText.isEmpty {
            tableHeaderView.searchField.leftView?.isHidden = false
            tableHeaderView.searchField.rightView?.isHidden = false
            isSearching = false
            filteredTasks = tasks
        } else {
            tableHeaderView.searchField.leftView?.isHidden = true
            tableHeaderView.searchField.rightView?.isHidden = true
            isSearching = true
            filteredTasks = tasks.filter { task in
                let titleMatch = task.title?.lowercased().contains(searchText) ?? false
                let descMatch = task.description?.lowercased().contains(searchText) ?? false
                return titleMatch || descMatch
            }
        }
        
        tableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
