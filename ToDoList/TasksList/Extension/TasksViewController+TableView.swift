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
        
        return cell
    }
}
