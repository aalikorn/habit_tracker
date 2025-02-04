//
//  HabitViewModel.swift
//  habit_tracker
//
//  Created by Даша Николаева on 03.02.2025.
//

import Foundation

class HabitViewModel {
    private let habitRepository: HabitRepositoryProtocol
    var todayHabits: [Habit]
    var thisWeekHabits: [Habit]
    var thisMonthHabits: [Habit]
    
    init(habitRepository: HabitRepositoryProtocol = HabitRepository()) {
        self.habitRepository = habitRepository
        todayHabits = [Habit(name: "aaa", frequency: .daily), Habit(name: "aaa", frequency: .daily)]
        thisWeekHabits = [Habit(name: "aaa", frequency: .daily)]
        thisMonthHabits = [Habit(name: "aaa", frequency: .daily)]
    }
    
    func fetchHabits() -> [Habit] {
        return habitRepository.fetchHabits()
    }
    
    func addHabit(name: String, frequency: Frequency, date: Date) -> Bool {
        let result = habitRepository.addHabit(name: name, frequency: frequency, date: date)
        if result {
            let habit = Habit(name: name, frequency: frequency, date: date)
            switch frequency {
            case .daily:
                todayHabits.append(habit)
            case .weekly:
                thisWeekHabits.append(habit)
            case .monthly:
                thisMonthHabits.append(habit)
            }
        }
        return result
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
    
    func setIsDone(name: String, isDone: Bool) -> Bool {
        return habitRepository.setIsDone(name: name, isDone: isDone)
    }
}
