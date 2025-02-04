//
//  DataManager.swift
//  habit_tracker
//
//  Created by Даша Николаева on 03.02.2025.
//

import Foundation
import CoreData

protocol DataManagerProtocol {
    func fetchHabits() -> [HabitEntity]
    func addHabit(name: String, frequency: Frequency, date: Date) -> Bool
    func removeHabit(name: String) -> Bool
    func editHabit(name: String, newName: String?, newFrequency: Frequency?, newDate: Date?) -> Bool
    func getHabit(name: String) -> HabitEntity?
    func setIsDone(name: String, isDone: Bool) -> Bool
}

class DataManager: DataManagerProtocol {
    private let context = CoreDataStack.shared.persistentContainer.viewContext
    
    func fetchHabits() -> [HabitEntity] {
        let fetchRequest: NSFetchRequest<HabitEntity> = HabitEntity.fetchRequest()
        do {
            let habits = try context.fetch(fetchRequest)
            return habits
        } catch {
            print("Ошибка при получении данных: \(error)")
            return []
        }
    }
    
    func addHabit(name: String, frequency: Frequency, date: Date) -> Bool {
        let newHabit = HabitEntity(context: context)
        newHabit.name = name
        newHabit.frequency = frequency.rawValue
        newHabit.startDate = date
        
        saveContext()
        return true
    }
    
    func removeHabit(name: String) -> Bool {
        let fetchRequest: NSFetchRequest<HabitEntity> = HabitEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let habits = try context.fetch(fetchRequest)
            if let habitToDelete = habits.first {
                context.delete(habitToDelete)
                saveContext()
                return true
            }
        } catch {
            print("Ошибка при удалении привычки: \(error)")
        }
        return false
    }
    
    func editHabit(name: String, newName: String?, newFrequency: Frequency?, newDate: Date?) -> Bool {
        let fetchRequest: NSFetchRequest<HabitEntity> = HabitEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let habits = try context.fetch(fetchRequest)
            if let habitToEdit = habits.first {
                if let newName = newName {
                    habitToEdit.name = newName
                }
                if let newFrequency = newFrequency {
                    habitToEdit.frequency = newFrequency.rawValue
                }
                if let newDate = newDate {
                    habitToEdit.startDate = newDate
                }

                
                try context.save()
                return true
            }
        } catch {
            print("Ошибка при изменении привычки: \(error)")
        }
        return false
    }
    
    func getHabit(name: String) -> HabitEntity? {
        let fetchRequest: NSFetchRequest<HabitEntity> = HabitEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
          do {
              let result = try context.fetch(fetchRequest)
              return result.first
          } catch {
              print("Ошибка при поиске привычки: \(error)")
              return nil
          }
    }
    
    func setIsDone(name: String, isDone: Bool) -> Bool {
        let fetchRequest: NSFetchRequest<HabitEntity> = HabitEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let result = try context.fetch(fetchRequest).first
            if let result = result {
                result.isDone = isDone
                result.lastResetDate = Date()
                return true
            }
            print("Привычка не найдена")
            return false
        } catch {
            print("Ошибка при поиске привычки: \(error)")
            return false
        }
    }
    
    func saveContext() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("Ошибка при сохранении: \(error)")
        }
    }
}
