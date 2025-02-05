//
//  AddHabitViewController.swift
//  habit_tracker
//
//  Created by Даша Николаева on 05.02.2025.
//

import UIKit

class AddHabitViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(dismissView))
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    
    
    @objc private func dismissView() {
       dismiss(animated: true)
   }
}
