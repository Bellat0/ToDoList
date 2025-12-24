//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Maxim Tvilinev on 24.12.2025.
//

import CoreData

final class CoreDataManager {

    static let shared = CoreDataManager(); private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoListModel")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("CoreData error: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
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
