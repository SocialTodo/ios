//
//  AddTICell.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/4/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import Foundation
import UIKit

protocol AddTICellDelegate {
    var dataController: DataController { get }
    var todoListId: Int { get }
    func addTodoItem(todoItem: TodoItem)
}

class AddTICell: UITableViewCell, UITextFieldDelegate {
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
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        return button
    }()

    var delegate: AddTICellDelegate!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        addSubview(background)
        addSubview(textField)
        addSubview(addButton)
    
        setupLayout()
        
        addButton.addTarget(self, action: #selector(handleAddTodoItem), for: .touchUpInside)
        textField.delegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleAddTodoItem() {
        print("handle add todo item")
        guard let title = textField.text else {
            return
        }
        let todoListId = delegate.todoListId
        
        let todoItem = TodoItem(title: title, isChecked: false, todoListId: todoListId)
        
        delegate.dataController.postTodoItem(todoItem: todoItem) { todoItem in
            self.delegate.addTodoItem(todoItem: todoItem)
        }
                
        textField.text = nil
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.typingAttributes = [NSAttributedStringKey.font.rawValue: UIFont(name: "AvenirNext-Regular", size: 22) ?? UIFont.boldSystemFont(ofSize: 22)]
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleAddTodoItem()
        return true
    }
    
    func setupLayout() {
        background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: leftAnchor, leftConstant: 12, right: rightAnchor, rightConstant: -12)
        background.anchorY(top: topAnchor, topConstant: 5, bottom: bottomAnchor, bottomConstant: -5)
        background.size(height: 60)

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        textField.anchorX(left: background.leftAnchor, leftConstant: 12, right: addButton.leftAnchor, rightConstant: -8)
        textField.size(height: 50)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        addButton.size(height: 30, width: 30)
        addButton.anchorX(left: textField.rightAnchor, leftConstant: 8, right: background.rightAnchor, rightConstant: -12)
    }
    
}



