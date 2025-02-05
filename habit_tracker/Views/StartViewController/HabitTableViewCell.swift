//
//  HabitTableViewCell.swift.swift
//  habit_tracker
//
//  Created by Даша Николаева on 04.02.2025.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
    static let identifier = "HabitTableViewCell"
    
    private let habitNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    private let checkboxButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        checkboxButton.addTarget(self, action: #selector(didTouchCheckbox), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(habitNameLabel)
        contentView.addSubview(checkboxButton)
        
        habitNameLabel.translatesAutoresizingMaskIntoConstraints = false
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        habitNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        habitNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
        habitNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

        
        checkboxButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        checkboxButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        checkboxButton.widthAnchor.constraint(equalToConstant: 30),
        checkboxButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func didTouchCheckbox() {
        checkboxButton.isSelected.toggle()
        updateHabitNameTextColor()
    }
    
    func configure(with habit: Habit) {
        habitNameLabel.text = habit.name
        checkboxButton.isSelected = habit.isDone
        updateHabitNameTextColor()
    }
    
    private func updateHabitNameTextColor() {
        habitNameLabel.textColor = checkboxButton.isSelected ? .gray : .black
    }
}
