//
//  LoginView.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 1/19/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import UIKit

class LoginView: UIViewController {
    let authController = AuthController()

    let background: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "login-background")
        iv.contentMode = .scaleAspectFill
        return iv
    }()

    let label: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Social Todo"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "AvenirNext-Bold", size: 38)
        return label
    }()

    let loginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1)
        button.setTitle("SIGN IN WITH FACEBOOK", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @objc func handleLoginButton() {
        authController.login(success: {
            self.dismiss(animated: true, completion: nil)
        })
    }

    func setupLayout() {
        view.addSubview(background)
        view.addSubview(label)
        view.addSubview(loginButton)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: view.leftAnchor, right: view.rightAnchor)
        background.anchorY(top: view.topAnchor, bottom: view.bottomAnchor)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.anchorY(top: view.topAnchor, topConstant: 25)
        label.anchorX(left: view.leftAnchor, leftConstant: 8, right: view.rightAnchor, rightConstant: -8)

        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.size(height: 40)
        loginButton.anchorX(left: view.leftAnchor, leftConstant: 8, right: view.rightAnchor, rightConstant: -8)
        loginButton.anchorY(bottom: view.bottomAnchor, bottomConstant: -25)
    }
}
