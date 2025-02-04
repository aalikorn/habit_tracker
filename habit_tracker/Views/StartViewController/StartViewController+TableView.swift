//
//  StartViewController+TableView.swift
//  habit_tracker
//
//  Created by Даша Николаева on 04.02.2025.
//

import UIKit


extension StartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return habitViewModel.todayHabits.count
        case 1: return habitViewModel.thisWeekHabits.count
        case 2: return habitViewModel.thisMonthHabits.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HabitTableViewCell.identifier, for: indexPath) as? HabitTableViewCell else {
                return UITableViewCell()
            }
        let habit = Habit(name: "бег", frequency: .daily)
        cell.configure(with: habit)
        
        return cell
    }
    
    func setupTableView() {
        habitsTableView.delegate = self
        habitsTableView.dataSource = self
        habitsTableView.register(HabitTableViewCell.self, forCellReuseIdentifier: HabitTableViewCell.identifier)
    }
    
    
}
