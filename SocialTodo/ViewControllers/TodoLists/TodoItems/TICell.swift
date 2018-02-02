//
//  TICell.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 1/28/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import Foundation
import UIKit

class TICell: UITableViewCell {
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        addSubview(background)
        addSubview(label)
        addSubview(todoCheckbox)
        
        setupLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout() {
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        background.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        background.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        background.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        background.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        todoCheckbox.translatesAutoresizingMaskIntoConstraints = false
        todoCheckbox.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        todoCheckbox.anchorX(left: background.leftAnchor, leftConstant: 12)
        todoCheckbox.size(height: 25, width: 25)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        label.anchorX(left: todoCheckbox.rightAnchor, leftConstant: 12, right: background.rightAnchor, rightConstant: -12)
        label.size(height: 50)
    }
    
}


