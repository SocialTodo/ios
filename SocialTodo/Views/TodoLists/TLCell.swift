//
//  TL-Cell.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 1/13/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import UIKit

protocol TLCellDelegate {
    var todoListsController: TodoListsController { get }
    func addTodoList(todoList: TodoList)
    func updateTodoList(cell: TLCell)
    func removeTodoList(cell: TLCell)
}

class TLCell: UITableViewCell {
    var delegate: TLCellDelegate!

	let background: UIImageView = {
		let iv = UIImageView()
		iv.image = #imageLiteral(resourceName: "TLCell")
		return iv
	}()

	let label: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "AvenirNext-DemiBold", size: 22.0)
		label.text = "Todo List"
		return label
	}()
    
    let sharedButton: SharedSwitch = {
        let sharedSwitch = SharedSwitch()
        return sharedSwitch
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
        addSubview(sharedButton)
        addSubview(trashButton)
    
		setupLayout()
        
        sharedButton.button.addTarget(self, action: #selector(toggleListShared), for: .touchUpInside)
        trashButton.addTarget(self, action: #selector(handleDeleteTodoList), for: .touchUpInside)
    }

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggleListShared() {
        if sharedButton.isShared {
            sharedButton.button.isEnabled = false
            sharedButton.isShared = false
            delegate.updateTodoList(cell: self)
            sharedButton.button.isEnabled = true
        } else {
            sharedButton.button.isEnabled = false
            sharedButton.isShared = true
            delegate.updateTodoList(cell: self)
            sharedButton.button.isEnabled = true
        }
    }
    
    @objc func handleDeleteTodoList() {
        self.delegate.removeTodoList(cell: self)
    }

	func setupLayout() {
        background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: leftAnchor, leftConstant: 12, right: rightAnchor, rightConstant: -12)
        background.anchorY(top: topAnchor, topConstant: 5, bottom: bottomAnchor, bottomConstant: -5)
        background.size(height: 60)

		label.translatesAutoresizingMaskIntoConstraints = false
		label.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        label.anchorX(left: background.leftAnchor, leftConstant: 12, right: sharedButton.leftAnchor, rightConstant: -12)
		label.size(height: 50)
        
        sharedButton.translatesAutoresizingMaskIntoConstraints = false
        sharedButton.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        sharedButton.anchorX(right: trashButton.leftAnchor, rightConstant: -8)
        sharedButton.size(height: 30, width: 100)
        
        trashButton.translatesAutoresizingMaskIntoConstraints = false
        trashButton.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        trashButton.anchorX(left: sharedButton.rightAnchor, leftConstant: 8, right: background.rightAnchor, rightConstant: -12)
        trashButton.size(height: 30, width: 21)

	}
}






