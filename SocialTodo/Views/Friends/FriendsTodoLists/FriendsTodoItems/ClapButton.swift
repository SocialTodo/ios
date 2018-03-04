//
//  ClapButton.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 3/4/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import UIKit

class ClapButton: UIView {
    var didClap: Bool
    var background: UIView
    var clapLabel: UILabel
    var countLabel: UILabel
    var button: UIButton
    
    override init(frame: CGRect) {
        
        background = UIView()
        background.layer.cornerRadius = 25
        background.backgroundColor = UIColor(r: 224, g: 241, b: 252)
        background.layer.borderWidth = 4
        background.layer.borderColor = UIColor(r: 0, g: 154, b: 255).cgColor
        background.clipsToBounds = true
        
        clapLabel = UILabel()
        clapLabel.text = "👏"
        clapLabel.font = UIFont(name: "Apple Color Emoji", size: 20)
        
        countLabel = UILabel()
        countLabel.text = "4"
        countLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 10)
        countLabel.textColor = UIColor(r: 3, g: 88, b: 140)
        
        button = UIButton()

        didClap = false
        
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(background)
        addSubview(clapLabel)
        addSubview(countLabel)
        addSubview(button)

        background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: leftAnchor, leftConstant: 0, right: rightAnchor, rightConstant: 0)
        background.anchorY(top: topAnchor, topConstant: 0, bottom: bottomAnchor, bottomConstant: 0)
        
        clapLabel.translatesAutoresizingMaskIntoConstraints = false
        clapLabel.centerXAnchor.constraint(equalTo: background.centerXAnchor).isActive = true
        clapLabel.anchorY(top: background.topAnchor, topConstant: 3)
        
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.centerXAnchor.constraint(equalTo: clapLabel.centerXAnchor).isActive = true
        countLabel.anchorY(top: clapLabel.bottomAnchor, topConstant: 2)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.anchorX(left: background.leftAnchor, leftConstant: 0, right: background.rightAnchor, rightConstant: 0)
        button.anchorY(top: background.topAnchor, topConstant: 0, bottom: background.bottomAnchor, bottomConstant: 0)
    }
}
