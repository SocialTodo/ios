//
//  FriendCell.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/9/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    let background: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "TLCell")
        return iv
    }()
    
    let thumbnail: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "profile"))
        iv.layer.cornerRadius = 25
        iv.clipsToBounds = true
        return iv
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 22.0)
        label.text = "Friend Name"
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        addSubview(background)
        addSubview(thumbnail)
        addSubview(label)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: leftAnchor, leftConstant: 12, right: rightAnchor, rightConstant: -12)
        background.anchorY(top: topAnchor, topConstant: 5, bottom: bottomAnchor, bottomConstant: -5)
        background.size(height: 60)
        
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        thumbnail.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        thumbnail.anchorX(left: background.leftAnchor, leftConstant: 12, right: label.leftAnchor, rightConstant: -8)
        thumbnail.size(height: 50, width: 50)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        label.anchorX(left: thumbnail.rightAnchor, leftConstant: 8, right: background.rightAnchor, rightConstant: -12)
        label.size(height: 50)
    }
}
