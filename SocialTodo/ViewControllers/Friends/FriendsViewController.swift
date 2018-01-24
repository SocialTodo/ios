//
//  FriendsViewController.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 12/3/17.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {

	let background: UIImageView = {
		let iv = UIImageView()
		iv.image = #imageLiteral(resourceName: "background")
		return iv
	}()

	let addButton: UIBarButtonItem = {
		let button = UIButton(type: .system)
		button.setTitle("Add+", for: .normal)
		button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
		button.tintColor = UIColor(red: 221/255, green: 242/255, blue: 255/255, alpha: 1)
		let barButton = UIBarButtonItem(customView: button)
		return barButton
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

		navigationItem.title = "Friends"

		navigationItem.leftBarButtonItem = addButton
		addButton.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAdd)))
		navigationItem.rightBarButtonItem = myListsButton
		myListsButton.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMyLists)))

		view.addSubview(background)
		setupLayout()

	}

	func setupLayout() {
		background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: view.leftAnchor, right: view.rightAnchor)
        background.anchorY(top: view.topAnchor, bottom: view.bottomAnchor)
	}

	@objc func showAdd() {
		print("show add+")
	}

	@objc func showMyLists() {
		print("show my lists")
	}

}
