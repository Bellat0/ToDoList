//
//  TasksModel.swift
//  ToDoList
//
//  Created by Maxim Tvilinev on 23.12.2025.
//

import Foundation

import Foundation

struct TaskModel {
    let id: UUID
    var isCompleted: Bool = false
    var title: String?
    var description: String?
    var date: Date
}
