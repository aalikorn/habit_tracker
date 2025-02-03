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
    
    init(name: String, frequency: Frequency) {
        self.name = name
        self.frequency = frequency
    }
}

enum Frequency: String, CaseIterable {
    case daily = "Every day"
    case weekly = "Once a week"
    case monthly = "Once a month"
}

