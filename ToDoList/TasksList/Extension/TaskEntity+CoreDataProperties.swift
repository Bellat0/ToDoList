//
//  TaskEntity+CoreDataProperties.swift
//  ToDoList
//
//  Created by Maxim Tvilinev on 24.12.2025.
//

import CoreData

extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var title: String?
    @NSManaged public var taskDescription: String?
    @NSManaged public var date: Date?
}

extension TaskEntity {
    func toModel() -> TaskModel {
        TaskModel(
            id: id ?? UUID(),
            isCompleted: isCompleted,
            title: title ?? "",
            description: taskDescription ?? "",
            date: date ?? Date()
        )
    }
    
    func toTaskModel() -> TaskModel {
        TaskModel(
            id: id ?? UUID(),
            isCompleted: isCompleted,
            title: title ?? "",
            description: taskDescription ?? "",
            date: date ?? Date()
        )
    }
}

extension TodoDTO {

    func toTaskModel() -> TaskModel {
        TaskModel(
            id: UUID(),
            isCompleted: completed,
            title: todo,
            description: "",
            date: Date()
        )
    }
}

extension TasksRepository {

    func save(tasks: [TaskModel]) {
        tasks.forEach { save(task: $0) }
    }

    func isEmpty() -> Bool {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        let count = (try? context.count(for: request)) ?? 0
        return count == 0
    }
}

enum AppLaunchState {
    static let hasLoadedInitialTodos = "hasLoadedInitialTodos"
}
