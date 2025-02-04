//
//  ViewController.swift
//  habit_tracker
//
//  Created by Даша Николаева on 02.02.2025.
//

import UIKit

class StartViewController: UIViewController {
    
    let habitViewModel = HabitViewModel()
    let habitsTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(habitsTableView)
        habitsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            habitsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            habitsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            habitsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }



}

