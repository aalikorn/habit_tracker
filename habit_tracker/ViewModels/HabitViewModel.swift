//
//  HabitViewModel.swift
//  habit_tracker
//
//  Created by Даша Николаева on 03.02.2025.
//

import Foundation

class HabitViewModel {
    private let habitRepository: HabitRepositoryProtocol
    
    init(habitRepository: HabitRepositoryProtocol = HabitRepository()) {
        self.habitRepository = habitRepository
    }
    
    func fetchHabits() -> [Habit] {
        return habitRepository.fetchHabits()
    }
    
    func addHabit(name: String, frequency: Frequency, date: Date) -> Bool {
        return habitRepository.addHabit(name: name, frequency: frequency, date: date)
    }
    
    func removeHabit(name: String) -> Bool {
        return habitRepository.removeHabit(name: name)
    }
    
    func getHabit(name: String) -> Habit? {
        return habitRepository.getHabit(name: name)
    }
    
    func editHabit(name: String, newName: String?, newFrequency: Frequency?, newDate: Date?) -> Bool {
        return habitRepository.editHabit(name: name, newName: newName, newFrequency: newFrequency, newDate: newDate)
    }
}
