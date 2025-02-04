//
//  Habit.swift
//  habit_tracker
//
//  Created by Даша Николаева on 03.02.2025.
//

import Foundation

class Habit {
    var name: String
    var frequency: Frequency
    var startDate: Date
    var isDone: Bool
    var lastResetDate: Date
    
    init(name: String, frequency: Frequency, date: Date = Date()) {
        self.name = name
        self.frequency = frequency
        self.startDate = date
        self.isDone = false
        self.lastResetDate = Date()
    }
}

enum Frequency: String, CaseIterable {
    case daily = "Every day"
    case weekly = "Once a week"
    case monthly = "Once a month"
}

