//
//  TabBarView.swift
//  habit_tracker
//
//  Created by Даша Николаева on 05.02.2025.
//

import UIKit

class TabBarView: UIView {
    private let addButton = UIButton()
    weak var viewController: UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupTabBar() {
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: -2)
        self.layer.shadowRadius = 4
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let viewController = viewController {
            NSLayoutConstraint.activate([
                self.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
                self.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor),
                self.heightAnchor.constraint(equalToConstant: 80)
            ])
        }
        setupAddButton()
    }
    
    private func setupAddButton() {
        addButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        addButton.tintColor = .systemBlue
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 100),
            addButton.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    @objc private func addButtonTapped() {
        let addHabitVC = AddHabitViewController()
        addHabitVC.modalPresentationStyle = .fullScreen
        viewController?.present(addHabitVC, animated: true, completion: nil)
    }
}
