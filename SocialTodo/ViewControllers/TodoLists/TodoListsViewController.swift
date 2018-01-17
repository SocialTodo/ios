//
//  TodoListsViewController.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 12/3/17.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import UIKit

class TodoListsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	let background: UIImageView = {
		let iv = UIImageView()
		iv.image = UIImage(named: "TLBackground")
		return iv
	}()

	let tableView: UITableView = {
		let tv = UITableView()
		tv.separatorStyle = .none
		tv.backgroundColor = UIColor.clear
		return tv
	}()

	let friendsButton: UIBarButtonItem = {
		let button = UIButton(type: .system)
		button.setTitle("Friends", for: .normal)
		button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
		button.tintColor = UIColor(red: 100/255, green: 191/255, blue: 251/255, alpha: 1)
		let barButton = UIBarButtonItem(customView: button)
		return barButton
	}()

	let profileButton: UIBarButtonItem = {
	let button = UIButton(type: .system)
	button.setTitle("Profile", for: .normal)
	button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
	button.tintColor = UIColor(red: 100/255, green: 191/255, blue: 251/255, alpha: 1)
	let barButton = UIBarButtonItem(customView: button)
	return barButton
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.title = "My Lists"

		navigationItem.leftBarButtonItem = friendsButton
		friendsButton.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showFriends)))
		navigationItem.rightBarButtonItem = profileButton
		profileButton.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showProfile)))

		view.addSubview(background)
		view.addSubview(tableView)

		setupLayout()

		tableView.dataSource = self
		tableView.delegate = self
	}

	func setupLayout() {
		background.translatesAutoresizingMaskIntoConstraints = false
		background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		background.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		background.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
	}

	@objc func showFriends() {
		print("123")
	}

	@objc func showProfile() {
		print("123")
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = TLCell(style: .default, reuseIdentifier: "TLCell")
		return cell
	}

}
