//
//  FriendsView.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 12/3/17.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import UIKit

class FriendsView: ScrollableViewController, UITableViewDataSource, UITableViewDelegate {
    //MARK:- Properties
    let friendsController = FriendsController()
    var friends = [Friend]()
    var friendsImages = [Int: UIImage]()
    let friendCell = "FriendCell"
    
    //MARK:- UI Elements
	let background: UIImageView = {
		let iv = UIImageView()
		iv.image = #imageLiteral(resourceName: "background")
		return iv
	}()

	let myListsButton: UIBarButtonItem = {
		let button = UIButton(type: .system)
		button.setTitle("My Lists", for: .normal)
		button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
		button.tintColor = UIColor(r: 221, g: 242, b: 255)
		let barButton = UIBarButtonItem(customView: button)
		return barButton
	}()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = UIColor.clear
        return tv
    }()
    
    //MARK:- Lifecycle Methods
	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.title = "Friends"

		navigationItem.rightBarButtonItem = myListsButton
		myListsButton.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMyLists)))
        
		setupLayout()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(FriendCell.self, forCellReuseIdentifier: friendCell)
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        friendsController.getFriends { (friends, friendsImages) in
            self.friends = friends
            self.friendsImages = friendsImages
            self.tableView.reloadData()
        }
    }

    //MARK:- UI Layout
	func setupLayout() {
        view.addSubview(background)
        view.addSubview(tableView)
        
        let margins = view.layoutMarginsGuide

		background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: view.leftAnchor, right: view.rightAnchor)
        background.anchorY(top: view.topAnchor, bottom: view.bottomAnchor)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.anchorX(left: view.leftAnchor, leftConstant: 8, right: view.rightAnchor, rightConstant: -8)
        tableView.anchorY(top: margins.topAnchor, bottom: margins.bottomAnchor)

	}
    
    //MARK:- UI Button Handlers
	@objc func showMyLists() {
		print("show my lists")
        scrollView.setContentOffset(CGPoint(x: self.view.frame.width * 1, y: 0.0), animated: true)
	}
    
    //MARK:- Table View Methods
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
        let friend = friends[indexPath.row]
        cell.label.text = friend.name
        cell.thumbnail.image = friendsImages[friend.facebookUserId]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = friends[indexPath.row]
        let friendsTodoListsView = FriendsTodoListsView(friend: friend)
        let navigationVC = UINavigationController(rootViewController: friendsTodoListsView)
        present(navigationVC, animated: true, completion: nil)
    }


}
