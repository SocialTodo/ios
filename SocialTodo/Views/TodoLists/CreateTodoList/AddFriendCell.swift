//
//  AddTLCell.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 1/31/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import UIKit

class AddFriendCell: UITableViewCell, UITextFieldDelegate {
    let background: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "TLCell")
        return iv
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.adjustsFontSizeToFitWidth = true
        tf.attributedPlaceholder = NSAttributedString(string: "Friend's Name", attributes: [NSAttributedStringKey.font: UIFont(name: "AvenirNext-UltraLight", size: 22) ?? UIFont.boldSystemFont(ofSize: 22), NSAttributedStringKey.foregroundColor: UIColor(r: 150, g: 150, b: 150)])
        tf.returnKeyType = .done
        return tf
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
        
        addButton.addTarget(self, action: #selector(handleAddFriend), for: .touchUpInside)
        textField.delegate = self
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleAddFriend() {
        print("handle add todo list")
        guard let friendName = textField.text else {
            return
        }
        
        textField.text = nil
        
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.typingAttributes = [NSAttributedStringKey.font.rawValue: UIFont(name: "AvenirNext-DemiBold", size: 22) ?? UIFont.boldSystemFont(ofSize: 22)]
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleAddFriend()
        return true
    }
    
    func setupLayout() {
        addSubview(background)
        addSubview(textField)
        addSubview(addButton)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: leftAnchor, right: rightAnchor)
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

