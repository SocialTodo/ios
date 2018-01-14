//
//  ProfileViewController.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 12/3/17.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

	let background: UIImageView = {
		let iv = UIImageView()
		iv.image = #imageLiteral(resourceName: "background")
		return iv
	}()

	let myListsButton: UIBarButtonItem = {
		let button = UIButton(type: .system)
		button.setTitle("My Lists", for: .normal)
		button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
		button.tintColor = UIColor(red: 221/255, green: 242/255, blue: 255/255, alpha: 1)
		let barButton = UIBarButtonItem(customView: button)
		return barButton
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.title = "Profile"

		navigationItem.leftBarButtonItem = myListsButton
		myListsButton.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMyLists)))

		view.addSubview(background)
		setupLayout()

	}

	func setupLayout() {
		background.translatesAutoresizingMaskIntoConstraints = false
		background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

	}

	@objc func showMyLists() {
		print("show my lists")
	}

}
