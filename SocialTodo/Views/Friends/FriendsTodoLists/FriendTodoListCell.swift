//
//  FriendTodoListCell.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/9/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import UIKit

class FriendTodoListCell: UITableViewCell {
    //MARK:- UI Elements
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
    
    //MARK:- Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- UI Layout
    func setupLayout() {
        addSubview(background)
        addSubview(label)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: leftAnchor, right: rightAnchor)
        background.anchorY(top: topAnchor, topConstant: 5, bottom: bottomAnchor, bottomConstant: -5)
        background.size(height: 60)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        label.anchorX(left: background.leftAnchor, leftConstant: 8, right: background.rightAnchor, rightConstant: -12)
        label.size(height: 50)
    }
}
