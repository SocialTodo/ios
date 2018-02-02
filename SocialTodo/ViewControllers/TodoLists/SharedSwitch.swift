//
//  SharedSwitch.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 1/29/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import Foundation
import UIKit

class SharedSwitch: UIView {
    var background: UIView!
    var slider: UIView!
    var sliderSharedConstraint: NSLayoutConstraint!
    var sliderPrivateConstraint: NSLayoutConstraint!
    var privateImage: UIImageView!
    var sharedImage: UIImageView!
    var isShared: Bool!
    var button: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        background = UIView()
        background.backgroundColor = .white
        background.layer.cornerRadius = 16
        background.layer.borderWidth = 2
        background.layer.borderColor = UIColor(r: 20, g: 130, b: 192).cgColor
        background.clipsToBounds = true
        addSubview(background)
        
        slider = UIView()
        slider.layer.cornerRadius = 0
        slider.backgroundColor = UIColor(r: 100, g: 191, b: 251)
        slider.layer.cornerRadius = 16
        slider.clipsToBounds = true
        addSubview(slider)
        
        sharedImage = UIImageView(image: #imageLiteral(resourceName: "shared"))
        addSubview(sharedImage)
        privateImage = UIImageView(image: #imageLiteral(resourceName: "private"))
        addSubview(privateImage)
        
        button = UIButton()
        addSubview(button)
        button.addTarget(self, action: #selector(toggleListShared), for: .touchUpInside)
        
        setupLayout()
        
        isShared = false
        sliderPrivateConstraint.isActive = true

        
    }
    
    @objc func toggleListShared() {
        if isShared {
            button.isEnabled = false
            isShared = false
            sliderSharedConstraint.isActive = false
            sliderPrivateConstraint.isActive = true
            button.isEnabled = true
        } else {
            button.isEnabled = false
            isShared = true
            sliderPrivateConstraint.isActive = false
            sliderSharedConstraint.isActive = true
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
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        sliderPrivateConstraint = slider.leftAnchor.constraint(equalTo: background.leftAnchor)
        sliderSharedConstraint = slider.rightAnchor.constraint(equalTo: background.rightAnchor)
        slider.size(width: 50)
        slider.anchorY(top: background.topAnchor, bottom: background.bottomAnchor)
        
        sharedImage.translatesAutoresizingMaskIntoConstraints = false
        sharedImage.anchorX(right: background.rightAnchor, rightConstant: -8)
        sharedImage.size(height: 25, width: 32)
        sharedImage.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        
        privateImage.translatesAutoresizingMaskIntoConstraints = false
        privateImage.anchorX(left: leftAnchor, leftConstant: 8)
        privateImage.size(height: 25, width: 25)
        privateImage.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
