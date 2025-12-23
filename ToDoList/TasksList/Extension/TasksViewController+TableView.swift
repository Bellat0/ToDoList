//
//  TasksViewController+TableView.swift
//  ToDoList
//
//  Created by Maxim Tvilinev on 23.12.2025.
//

import UIKit

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TaskCell.ID,
            for: indexPath
        ) as? TaskCell else { return UITableViewCell() }
        
        let task = filteredTasks[indexPath.row]
        cell.configure(with: task)
        
        cell.onStatusToggle = { [weak self] in
            guard let self else { return }
            
            self.filteredTasks[indexPath.row].isCompleted.toggle()
            
            if let originalIndex = self.tasks.firstIndex(where: {
                $0.title == task.title && $0.date == task.date
            }) {
                self.tasks[originalIndex].isCompleted =
                self.filteredTasks[indexPath.row].isCompleted
            }
            
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        return cell
    }
    
    // MARK: - UIContextMenuConfiguration
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            
            let editAction = UIAction(title: "Редактировать", image: UIImage(systemName: "square.and.pencil")) { _ in
                
            }
            
            let shareAction = UIAction(title: "Поделиться", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                self.presentShareController(for: indexPath)
            }
            
            let deleteAction = UIAction(title: "Удалить", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
                self.filteredTasks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            return UIMenu(title: "", children: [editAction, shareAction, deleteAction])
        }
    }
}
