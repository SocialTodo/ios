//
//  TodoCheckbox.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/1/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import Foundation
import UIKit

class TodoCheckbox: UIView {
    var background: UIView!
    var isChecked: Bool!
    var button: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        background = UIView()
        background.backgroundColor = .white
        background.layer.cornerRadius = 8
        background.layer.borderWidth = 3
        background.layer.borderColor = UIColor(r: 0, g: 87, b: 139).cgColor
        background.clipsToBounds = true
        addSubview(background)
        
        button = UIButton()
        addSubview(button)
        button.addTarget(self, action: #selector(toggleCheckTodo), for: .touchUpInside)
        
        setupLayout()
        
        isChecked = false
        
        
    }
    
    @objc func toggleCheckTodo() {
        if isChecked {
            button.isEnabled = false
            isChecked = false
            background.backgroundColor = .white
            button.isEnabled = true
        } else {
            button.isEnabled = false
            isChecked = true
            background.backgroundColor = UIColor(r: 100, g: 191, b: 251)
            button.isEnabled = true
        }
    }
    
    func setupLayout() {
        
        background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: leftAnchor, leftConstant: 0, right: rightAnchor, rightConstant: 0)
        background.anchorY(top: topAnchor, topConstant: 0, bottom: bottomAnchor, bottomConstant: 0)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.anchorX(left: background.leftAnchor, right: background.rightAnchor)
        button.anchorY(top: background.topAnchor, bottom: background.bottomAnchor)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
