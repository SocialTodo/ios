//
//  FriendsView.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 12/3/17.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import UIKit

class FriendsView: ScrollableViewController {

	let background: UIImageView = {
		let iv = UIImageView()
		iv.image = #imageLiteral(resourceName: "background")
		return iv
	}()

	let addButton: UIBarButtonItem = {
		let button = UIButton(type: .system)
		button.setTitle("Add+", for: .normal)
		button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
		button.tintColor = UIColor(red: 221/255, green: 242/255, blue: 255/255, alpha: 1)
		let barButton = UIBarButtonItem(customView: button)
		return barButton
	}()

	let myListsButton: UIBarButtonItem = {
		let button = UIButton(type: .system)
		button.setTitle("My Lists", for: .normal)
		button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
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
        scrollView.setContentOffset(CGPoint(x: self.view.frame.width * 0, y: 0.0), animated: true)
	}

	@objc func showMyLists() {
		print("show my lists")
        scrollView.setContentOffset(CGPoint(x: self.view.frame.width * 2, y: 0.0), animated: true)
	}

}