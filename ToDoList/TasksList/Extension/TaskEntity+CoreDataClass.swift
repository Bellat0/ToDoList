//
//  TaskEntity+CoreDataClass.swift
//  ToDoList
//
//  Created by Maxim Tvilinev on 23.12.2025.
//

import CoreData

final class CoreDataManager {

    static let shared = CoreDataManager()
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoListModel")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("CoreData error: \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }
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
