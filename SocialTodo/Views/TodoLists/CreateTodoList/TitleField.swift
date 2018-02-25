//
//  TitleField.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/24/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import UIKit

class TitleField: UIView, UITextFieldDelegate {
    let background: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "TLCell")
        return iv
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 24)
        label.textColor = UIColor(r: 0, g: 88, b: 142)
        label.text = "Title:"
        return label
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.adjustsFontSizeToFitWidth = true
        tf.defaultTextAttributes = [NSAttributedStringKey.font.rawValue: UIFont(name: "AvenirNext-Regular", size: 24) ?? UIFont.boldSystemFont(ofSize: 24), NSAttributedStringKey.foregroundColor.rawValue: UIColor(r: 65, g: 107, b: 132)]
        tf.placeholder = "Todo List Title"
        tf.returnKeyType = .done
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        
        textField.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(background)
        addSubview(label)
        addSubview(textField)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: leftAnchor, right: rightAnchor)
        background.anchorY(top: topAnchor, bottom: bottomAnchor)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.anchorX(left: leftAnchor, leftConstant: 8, right: textField.leftAnchor, rightConstant: -8)
        label.size(width: 60)
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.anchorX(left: label.rightAnchor, leftConstant: 8, right: rightAnchor, rightConstant: -8)
        textField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
}
