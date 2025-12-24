//
//  TodosModel.swift
//  ToDoList
//
//  Created by Maxim Tvilinev on 24.12.2025.
//

import Foundation

nonisolated struct TodosModel: Decodable {
    let todos: [TodoDTO]
}

nonisolated struct TodoDTO: Decodable {
    let id: Int
    let todo: String
    let completed: Bool
}
