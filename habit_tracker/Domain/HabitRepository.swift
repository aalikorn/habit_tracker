//
//  HabitRepository.swift.swift
//  habit_tracker
//
//  Created by Даша Николаева on 03.02.2025.
//

import Foundation

protocol HabitRepositoryProtocol {
    func fetchHabits() -> [Habit]
    func addHabit(name: String, frequency: Frequency, date: Date) -> Bool
    func removeHabit(name: String) -> Bool
    func editHabit(name: String, newName: String?, newFrequency: Frequency?, newDate: Date?) -> Bool
    func getHabit(name: String) -> Habit?
    func setIsDone(name: String, isDone: Bool) -> Bool
}


class HabitRepository: HabitRepositoryProtocol {
    let dataManager: DataManagerProtocol
    init(dataManager: DataManagerProtocol = DataManager()) {
        self.dataManager = dataManager
    }
    
    func fetchHabits() -> [Habit] {
        let entities = dataManager.fetchHabits()
        return entities.map(habitEntityToHabit)
    }
    
    func addHabit(name: String, frequency: Frequency, date: Date) -> Bool {
        return dataManager.addHabit(name: name, frequency: frequency, date: date)
    }
    
    func removeHabit(name: String) -> Bool {
        return dataManager.removeHabit(name: name)
    }
    
    func editHabit(name: String, newName: String?, newFrequency: Frequency?, newDate: Date?) -> Bool {
        return dataManager.editHabit(name: name, newName: newName, newFrequency: newFrequency, newDate: newDate)
    }
    
    func getHabit(name: String) -> Habit? {
        return dataManager.getHabit(name: name).flatMap(habitEntityToHabit)
    }
    
    func setIsDone(name: String, isDone: Bool) -> Bool {
        return dataManager.setIsDone(name: name, isDone: isDone)
    }
    
    func habitEntityToHabit(entity: HabitEntity) -> Habit {
        return Habit(
            name: entity.name ?? "Без названия",
            frequency: Frequency(rawValue: entity.frequency ?? "daily") ?? .daily,
            date: entity.startDate ?? Date()
        )
    }
    
}
