//
//  TodoListsViewController.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 12/3/17.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import UIKit

class TodoListsViewController: ScrollableViewController, UITableViewDataSource, UITableViewDelegate {

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
		button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
		button.tintColor = UIColor(red: 100/255, green: 191/255, blue: 251/255, alpha: 1)
		let barButton = UIBarButtonItem(customView: button)
		return barButton
	}()

	let profileButton: UIBarButtonItem = {
	let button = UIButton(type: .system)
	button.setTitle("Profile", for: .normal)
	button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
	button.tintColor = UIColor(red: 100/255, green: 191/255, blue: 251/255, alpha: 1)
	let barButton = UIBarButtonItem(customView: button)
	return barButton
	}()
    
    var todoLists: [TodoList]?
    let todoListCell = "TLCell"
    let addTodoListCell = "AddTLCell"
    
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
        
        tableView.register(TLCell.self, forCellReuseIdentifier: todoListCell)
        tableView.register(AddTLCell.self, forCellReuseIdentifier: addTodoListCell)

        
        dataController.getMyLists() { todoLists in
            self.todoLists = todoLists
            self.tableView.reloadData()
        }
        
    }

	func setupLayout() {
		background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: view.leftAnchor, right: view.rightAnchor)
        background.anchorY(top: view.topAnchor, bottom: view.bottomAnchor)

		tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.anchorX(left: view.leftAnchor, right: view.rightAnchor)
        tableView.anchorY(top: view.topAnchor, bottom: view.bottomAnchor)
	}

	@objc func showFriends() {
        scrollView.setContentOffset(CGPoint(x: self.view.frame.width, y: 0.0), animated: true)
	}

	@objc func showProfile() {
        scrollView.setContentOffset(CGPoint(x: self.view.frame.width * 3, y: 0.0), animated: true)
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (todoLists?.count ?? 0) + 1
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < todoLists?.count ?? 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: todoListCell, for: indexPath) as! TLCell
            let list = todoLists![indexPath.row]
            cell.label.text = list.title
            cell.sharedButton.isShared = list.isShared
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: addTodoListCell, for: indexPath) as! AddTLCell
            cell.dataController = dataController
            return cell
        }
        
	}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let TodoItemVC = TodoItemsViewController()
        let navigationVC = UINavigationController(rootViewController: TodoItemVC)
        present(navigationVC, animated: true, completion: nil)
    }

}
