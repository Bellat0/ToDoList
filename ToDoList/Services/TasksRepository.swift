//
//  TasksRepository.swift
//  ToDoList
//
//  Created by Maxim Tvilinev on 24.12.2025.
//

import CoreData

final class TasksRepository {

    let context = CoreDataManager.shared.context

    func fetchTasks() -> [TaskModel] {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]

        let entities = (try? context.fetch(request)) ?? []
        return entities.map { $0.toModel() }
    }

    func save(task: TaskModel) {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)

        let entity = (try? context.fetch(request).first)
            ?? TaskEntity(context: context)

        entity.id = task.id
        entity.title = task.title
        entity.taskDescription = task.description
        entity.date = task.date
        entity.isCompleted = task.isCompleted

        CoreDataManager.shared.saveContext()
    }
    
    func saveInitialTasks(_ models: [TaskModel], completion: @escaping () -> Void) {
        CoreDataManager.shared.persistentContainer.performBackgroundTask { context in
            models.forEach { task in
                let entity = TaskEntity(context: context)
                entity.id = task.id
                entity.title = task.title
                entity.taskDescription = task.description
                entity.date = task.date
                entity.isCompleted = task.isCompleted
            }
            
            do {
                try context.save()
                DispatchQueue.main.async {
                    completion()
                }
            } catch {
                print("Ошибка сохранения: \(error)")
            }
        }
    }
}
