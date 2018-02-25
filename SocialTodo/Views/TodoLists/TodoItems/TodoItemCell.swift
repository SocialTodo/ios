//
//  TodoItemCell.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 1/28/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import Foundation
import UIKit

class TodoItemCell: UITableViewCell {
    var delegate: TodoItemDelegate!
    
    let background: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "TLCell")
        return iv
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 22.0)
        label.text = "Todo"
        return label
    }()
    
    let todoCheckbox: TodoCheckbox = {
        let todoCheckbox = TodoCheckbox()
        return todoCheckbox
    }()
    
    let trashButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "trash"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        addSubview(background)
        addSubview(label)
        addSubview(todoCheckbox)
        addSubview(trashButton)
        
        setupLayout()
        
        todoCheckbox.button.addTarget(self, action: #selector(toggleCheckTodo), for: .touchUpInside)
        trashButton.addTarget(self, action: #selector(handleDeleteTodoList), for: .touchUpInside)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggleCheckTodo() {
        if todoCheckbox.isChecked {
            todoCheckbox.button.isEnabled = false
            todoCheckbox.isChecked = false
            delegate.updateTodoItem(cell: self)
            todoCheckbox.button.isEnabled = true
        } else {
            todoCheckbox.button.isEnabled = false
            todoCheckbox.isChecked = true
            delegate.updateTodoItem(cell: self)
            todoCheckbox.button.isEnabled = true
        }
    }
    
    @objc func handleDeleteTodoList() {
        self.delegate.removeTodoItem(cell: self)
    }

    
    func setupLayout() {
        background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: leftAnchor, leftConstant: 12, right: rightAnchor, rightConstant: -12)
        background.anchorY(top: topAnchor, topConstant: 5, bottom: bottomAnchor, bottomConstant: -5)
        background.size(height: 60)
        
        todoCheckbox.translatesAutoresizingMaskIntoConstraints = false
        todoCheckbox.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        todoCheckbox.anchorX(left: background.leftAnchor, leftConstant: 12)
        todoCheckbox.size(height: 25, width: 25)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        label.anchorX(left: todoCheckbox.rightAnchor, leftConstant: 12, right: trashButton.leftAnchor, rightConstant: -8)
        label.size(height: 50)
        
        trashButton.translatesAutoresizingMaskIntoConstraints = false
        trashButton.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        trashButton.anchorX(left: label.rightAnchor, leftConstant: 8, right: background.rightAnchor, rightConstant: -12)
        trashButton.size(height: 30, width: 21)
        
        
    }
    
}


