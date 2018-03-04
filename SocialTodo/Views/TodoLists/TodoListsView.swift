//
//  TodoListsView.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 12/3/17.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import UIKit

class TodoListsView: ScrollableViewController, UITableViewDataSource, UITableViewDelegate, TodoListDelegate {
    //MARK:- Properties
    let todoListsController = TodoListsController()
    var todoLists: [TodoList]?
    let todoListCell = "TodoListCell"

    //MARK:- UI Elements
	let background: UIImageView = {
		let iv = UIImageView()
		iv.image = UIImage(named: "TLBackground")
		return iv
	}()

	let friendsButton: UIBarButtonItem = {
		let button = UIButton(type: .system)
		button.setTitle("Friends", for: .normal)
		button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
		button.tintColor = UIColor(r: 100, g: 191, b: 251)
		let barButton = UIBarButtonItem(customView: button)
		return barButton
	}()

	let profileButton: UIBarButtonItem = {
        let button = UIButton(type: .system)
        button.setTitle("Profile", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
        button.tintColor = UIColor(r: 100, g: 191, b: 251)
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

        setupNavBar()
		setupLayout()

		tableView.dataSource = self
		tableView.delegate = self
        
        tableView.register(TodoListCell.self, forCellReuseIdentifier: todoListCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
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
    
    //MARK:- UI Layout
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "My Lists"
        
        navigationItem.leftBarButtonItem = friendsButton
        friendsButton.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showFriends)))
        navigationItem.rightBarButtonItem = profileButton
        profileButton.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showProfile)))
    }

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
	@objc func showFriends() {
        scrollView.setContentOffset(CGPoint(x: self.view.frame.width * 0, y: 0.0), animated: true)
	}

	@objc func showProfile() {
        scrollView.setContentOffset(CGPoint(x: self.view.frame.width * 2, y: 0.0), animated: true)
	}
    
    @objc func handleCreateTodoList() {
        let createTodoListView = CreateTodoList(todoListDelegate: self)
        let navController = UINavigationController(rootViewController: createTodoListView)
        navController.navigationBar.barTintColor = UIColor(r: 0, g: 154, b: 233)
        navController.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 28) ?? UIFont.boldSystemFont(ofSize: 28), NSAttributedStringKey.foregroundColor: UIColor.white]
        self.present(navController, animated: true, completion: nil)
    }

    //MARK:- Table View Methods
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return todoLists?.count ?? 0
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: todoListCell, for: indexPath) as! TodoListCell
        cell.delegate = self
        let list = todoLists![indexPath.row]
        cell.label.text = list.title
        cell.sharedButton.isShared = list.isShared
        return cell
	}
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        
        let addView = UIView()
        addView.translatesAutoresizingMaskIntoConstraints = false
        addView.size(height: 45, width: 45)
        addView.layer.cornerRadius = 45/2
        addView.layer.borderColor = UIColor(r: 0, g: 144, b: 231).cgColor
        addView.layer.borderWidth = 2
        addView.backgroundColor = .white
        
        footerView.addSubview(addView)
        addView.anchorX(right: footerView.rightAnchor, rightConstant: -8)
        addView.anchorY(bottom: footerView.bottomAnchor)
        
        let addButton = UIButton()
        addButton.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        addButton.addTarget(self, action: #selector(handleCreateTodoList), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.size(height: 45, width: 45)
        addView.addSubview(addButton)
        addButton.anchorX(right: addView.rightAnchor)
        addButton.anchorY(bottom: addView.bottomAnchor)

        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let todoLists = todoLists else {
            return
        }
        let todoList = todoLists[indexPath.row]
        let TodoItemVC = TodoItemsView(todoList: todoList, todoListIndex: indexPath.row, todoListDelegate: self)
        scrollView.isScrollEnabled = false
        navigationController?.pushViewController(TodoItemVC, animated: true)
    }
    
    //MARK:- Todo List Methods
    func didPopTodoItemsView() {
        scrollView.isScrollEnabled = true
    }
    
    func didAddTodoList(todoList: TodoList) {
        todoLists?.append(todoList)
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            let indexPath = IndexPath(row: self.todoLists!.count - 1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .left)
            self.tableView.endUpdates()
        }
    }
    
    func didRemoveTodoList(cell: TodoListCell) {
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
    
    func didUpdateTodoList(todoListIndex: Int, todoList: TodoList) {
        self.todoLists![todoListIndex] = todoList
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didUpdateTodoListSharing(cell: TodoListCell) {
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
    


}
