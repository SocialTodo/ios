//
//  FriendsView.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 12/3/17.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import UIKit

class FriendsView: ScrollableViewController, UITableViewDataSource, UITableViewDelegate {
    let friendsController = FriendsController()
    var friends = [Friend]()
    
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
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = UIColor.clear
        return tv
    }()

    let friendCell = "FriendCell"
    
	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.title = "Friends"

		navigationItem.leftBarButtonItem = addButton
		addButton.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAdd)))
		navigationItem.rightBarButtonItem = myListsButton
		myListsButton.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMyLists)))

		view.addSubview(background)
        view.addSubview(tableView)
        
		setupLayout()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(FriendCell.self, forCellReuseIdentifier: friendCell)
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        friendsController.getFriends { friends in
            self.friends.append(contentsOf: friends)
            self.tableView.reloadData()
        }
    }

	func setupLayout() {
        let margins = view.layoutMarginsGuide

		background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: view.leftAnchor, right: view.rightAnchor)
        background.anchorY(top: view.topAnchor, bottom: view.bottomAnchor)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.anchorX(left: view.leftAnchor, right: view.rightAnchor)
        tableView.anchorY(top: margins.topAnchor, bottom: margins.bottomAnchor)

	}

	@objc func showAdd() {
		print("show add+")
        scrollView.setContentOffset(CGPoint(x: self.view.frame.width * 0, y: 0.0), animated: true)
	}

	@objc func showMyLists() {
		print("show my lists")
        scrollView.setContentOffset(CGPoint(x: self.view.frame.width * 2, y: 0.0), animated: true)
	}
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: friendCell, for: indexPath) as! FriendCell
        cell.label.text = friends[indexPath.row].name
        return cell
    }


}
