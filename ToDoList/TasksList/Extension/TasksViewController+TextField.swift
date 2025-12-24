//
//  TasksViewController+TextField.swift
//  ToDoList
//
//  Created by Maxim Tvilinev on 23.12.2025.
//

import UIKit

extension TasksViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let searchText = textField.text?.lowercased() ?? ""
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            let filtered = searchText.isEmpty ? self.tasks : self.tasks.filter {
                ($0.title?.lowercased().contains(searchText) ?? false) ||
                ($0.description?.lowercased().contains(searchText) ?? false)
            }
            
            DispatchQueue.main.async {
                self.filteredTasks = filtered
                self.tableView.reloadData()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
