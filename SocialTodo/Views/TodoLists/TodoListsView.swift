//
//  TodoListsView.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 12/3/17.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import UIKit

class TodoListsView: ScrollableViewController, UITableViewDataSource, UITableViewDelegate, TLCellDelegate {
    let todoListsController = TodoListsController()

	let background: UIImageView = {
		let iv = UIImageView()
		iv.image = UIImage(named: "TLBackground")
		return iv
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
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = UIColor.clear
        return tv
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        todoListsController.getMyLists() { todoLists in
            self.todoLists = todoLists
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
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
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: self.tableView.contentInset.top, left: self.tableView.contentInset.left, bottom: self.tableView.contentInset.bottom + keyboardSize.height, right: self.tableView.contentInset.right)
            self.tableView.contentInset = contentInsets
            let indexPath = IndexPath(row: todoLists?.count ?? 0, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {

            let contentInsets = UIEdgeInsets(top: self.tableView.contentInset.top, left: self.tableView.contentInset.left, bottom: self.tableView.contentInset.bottom - keyboardSize.height, right: self.tableView.contentInset.right)
            self.tableView.contentInset = contentInsets
            self.tableView.scrollIndicatorInsets = contentInsets
        }
    }

	@objc func showFriends() {
        scrollView.setContentOffset(CGPoint(x: self.view.frame.width * 0, y: 0.0), animated: true)
	}

	@objc func showProfile() {
        scrollView.setContentOffset(CGPoint(x: self.view.frame.width * 2, y: 0.0), animated: true)
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
            cell.delegate = self
            let list = todoLists![indexPath.row]
            cell.label.text = list.title
            cell.sharedButton.isShared = list.isShared
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: addTodoListCell, for: indexPath) as! AddTLCell
            cell.delegate = self
            return cell
        }
        
	}
    
    func addTodoList(todoList: TodoList) {
        todoLists?.append(todoList)
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            var indexPath = IndexPath(row: self.todoLists!.count - 1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .left)
            self.tableView.endUpdates()
            indexPath = IndexPath(row: self.todoLists!.count, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func removeTodoList(cell: TLCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        todoListsController.removeTodoList(todoList: todoLists![indexPath.row] ) {
            self.todoLists!.remove(at: indexPath.row)
            DispatchQueue.main.async {
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: .right)
                self.tableView.endUpdates()
            }
        }
    }
    
    func updateTodoList(cell: TLCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        let oldTodoList = todoLists![indexPath.row]
        let todoList = TodoList(id: oldTodoList.id!, title: cell.label.text!, isShared: cell.sharedButton.isShared)
        
        todoListsController.updateTodoList(todoList: todoList) { todoList in
            self.todoLists![indexPath.row] = todoList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let todoLists = todoLists else {
            return
        }
        guard indexPath.row < todoLists.count else {
            return
        }
        let todoList = todoLists[indexPath.row]
        let TodoItemVC = TodoItemsView(todoList: todoList, todoListsController: todoListsController)
        let navigationVC = UINavigationController(rootViewController: TodoItemVC)
        present(navigationVC, animated: true, completion: nil)
    }

}
