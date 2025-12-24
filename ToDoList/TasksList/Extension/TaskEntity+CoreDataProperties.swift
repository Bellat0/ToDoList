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
}
