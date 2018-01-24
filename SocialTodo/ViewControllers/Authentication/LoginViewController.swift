//
//  LoginViewController.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 1/19/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import UIKit
import FacebookCore

class LoginViewController: UIViewController {
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

    let authController = AuthController()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(background)
        view.addSubview(label)
        view.addSubview(loginButton)

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
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true

        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25).isActive = true
        loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50)
    }
}
