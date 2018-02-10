//
//  AddTLCell.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 1/31/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import UIKit



class AddTLCell: UITableViewCell, UITextFieldDelegate {
    var delegate: TLCellDelegate!
    
    let background: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "TLCell")
        return iv
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.adjustsFontSizeToFitWidth = true
        tf.attributedPlaceholder = NSAttributedString(string: "Add Todo List", attributes: [NSAttributedStringKey.font: UIFont(name: "AvenirNext-UltraLight", size: 22) ?? UIFont.boldSystemFont(ofSize: 22), NSAttributedStringKey.foregroundColor: UIColor(r: 150, g: 150, b: 150)])
        tf.returnKeyType = .done
        return tf
    }()
    
    let sharedButton: SharedSwitch = {
        let sharedSwitch = SharedSwitch()
        return sharedSwitch
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        addSubview(background)
        addSubview(textField)
        addSubview(sharedButton)
        addSubview(addButton)
        
        addButton.addTarget(self, action: #selector(handleAddTodoList), for: .touchUpInside)
        textField.delegate = self
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleAddTodoList() {
        print("handle add todo list")
        guard let title = textField.text else {
            return
        }
        guard let isShared = sharedButton.isShared else {
            return
        }
        
        let todoList = TodoList(id: nil, title: title, isShared: isShared)
        delegate.todoListsController.postTodoList(todoList: todoList) { todoList in
            self.delegate.addTodoList(todoList: todoList)
        }
        
        
        textField.text = nil
        sharedButton.isShared = false
        
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.typingAttributes = [NSAttributedStringKey.font.rawValue: UIFont(name: "AvenirNext-DemiBold", size: 22) ?? UIFont.boldSystemFont(ofSize: 22)]
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleAddTodoList()
        return true
    }
    
    func setupLayout() {
        background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: leftAnchor, leftConstant: 12, right: rightAnchor, rightConstant: -12)
        background.anchorY(top: topAnchor, topConstant: 5, bottom: bottomAnchor, bottomConstant: -5)
        background.size(height: 60)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        textField.anchorX(left: background.leftAnchor, leftConstant: 12, right: sharedButton.leftAnchor, rightConstant: -8)
        textField.size(height: 50)
        
        sharedButton.translatesAutoresizingMaskIntoConstraints = false
        sharedButton.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        sharedButton.anchorX(left: textField.rightAnchor, leftConstant: 8, right: addButton.leftAnchor, rightConstant: -8)
        sharedButton.size(height: 30, width: 100)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        addButton.size(height: 30, width: 30)
        addButton.anchorX(left: sharedButton.rightAnchor, leftConstant: 8, right: background.rightAnchor, rightConstant: -12)
    }
}

