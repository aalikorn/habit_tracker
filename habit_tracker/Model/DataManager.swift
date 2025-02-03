//
//  DataManager.swift
//  habit_tracker
//
//  Created by Даша Николаева on 03.02.2025.
//

import Foundation
import CoreData

protocol DataManagerProtocol {
    func fetchHabits() -> [Habit]
    func addHabit(name: String, frequency: Frequency) -> Bool
    func removeHabit(name: String) -> Bool
    func editHabit(name: String, newName: String?, newFrequency: Frequency?) -> Bool
    func getHabit(name: String) -> Habit?
}

class DataManager: DataManagerProtocol {
    private let context = CoreDataStack.shared.persistentContainer.viewContext
    
    func fetchHabits() -> [Habit] {
        let fetchRequest: NSFetchRequest<HabitEntity> = HabitEntity.fetchRequest()
        do {
            let habits = try context.fetch(fetchRequest)
            return habits.map(habitEntityToHabit(entity:))
        } catch {
            print("Ошибка при получении данных: \(error)")
            return []
        }
    }
    
    func addHabit(name: String, frequency: Frequency) -> Bool {
        let newHabit = HabitEntity(context: context)
        newHabit.name = name
        newHabit.frequency = frequency.rawValue
        
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
    
    func editHabit(name: String, newName: String?, newFrequency: Frequency?) -> Bool {
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
                
                try context.save()
                return true
            }
        } catch {
            print("Ошибка при изменении привычки: \(error)")
        }
        return false
    }
    
    func getHabit(name: String) -> Habit? {
        let fetchRequest: NSFetchRequest<HabitEntity> = HabitEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
          do {
              let result = try context.fetch(fetchRequest)
              return result.first.map(habitEntityToHabit(entity:))
          } catch {
              print("Ошибка при поиске привычки: \(error)")
              return nil
          }
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Ошибка при сохранении: \(error)")
        }
    }
    
    func habitEntityToHabit(entity: HabitEntity) -> Habit {
        return Habit(
            name: entity.name ?? "Без названия",
            frequency: Frequency(rawValue: entity.frequency ?? "daily") ?? .daily
        )
    }
}
