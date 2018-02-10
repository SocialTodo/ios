//
//  AddFriendsView.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 12/3/17.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import UIKit

class AddFriendsView: ScrollableViewController, UITableViewDelegate, UITableViewDataSource {

	let background: UIImageView = {
		let iv = UIImageView()
		iv.image = #imageLiteral(resourceName: "background")
		return iv
	}()

	let friendsButton: UIBarButtonItem = {
		let button = UIButton(type: .system)
		button.setTitle("Friends", for: .normal)
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
    
    let addFriendCell = "AddFriendCell"
    
	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.title = "Add+"

		navigationItem.rightBarButtonItem = friendsButton
		friendsButton.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showFriends)))

		view.addSubview(background)
        view.addSubview(tableView)
		setupLayout()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(AddFriendCell.self, forCellReuseIdentifier: addFriendCell)
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

	@objc func showFriends() {
		print("show friends")
        scrollView.setContentOffset(CGPoint(x: self.view.frame.width, y: 0.0), animated: true)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: addFriendCell, for: indexPath) as! AddFriendCell
        return cell
    }

}
