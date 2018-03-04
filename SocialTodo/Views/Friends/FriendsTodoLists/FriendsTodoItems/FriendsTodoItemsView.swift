//
//  FriendsTodoItemsView.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/9/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import UIKit

class FriendsTodoItemsView: UIViewController, UITableViewDataSource, UITableViewDelegate, TodoItemDelegate {
    //MARK:- Properties
    let todoItemsController = TodoItemsController()
    
    var todoList: TodoList {
        didSet {
            DispatchQueue.main.async {
                self.navigationItem.title = self.todoList.title
            }
        }
    }
    var todoItems: [TodoItem]?
    let friendTodoItemCell = "FriendTodoItemCell"
    let addTodoItemCell = "AddTodoItemCell"
    
    //MARK:- UI Elements
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
    
    //MARK:- Init
    init(todoList: TodoList) {
        self.todoList = todoList
//        self.todoListDelegate = todoListDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupLayout()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(FriendTodoItemCell.self, forCellReuseIdentifier: friendTodoItemCell)
        tableView.register(AddTodoItemCell.self, forCellReuseIdentifier: addTodoItemCell)
        
        todoItemsController.getTodoItems(todoListId: todoList.id!) { (todoItems) in
            self.todoItems = todoItems
            self.tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        todoListDelegate.didPopTodoItemsView()
    }
    
    //MARK:- UI Layout
    func setupNavBar() {
        navigationItem.title = todoList.title
        
        if let navigationController = navigationController {
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.barTintColor = UIColor(r: 0, g: 154, b: 233)
            navigationController.navigationBar.tintColor = UIColor(r: 199, g: 244, b: 250)
            navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 32) ?? UIFont.boldSystemFont(ofSize: 28), NSAttributedStringKey.foregroundColor: UIColor.white]
        }
        
    }
    
    func setupLayout() {
        view.addSubview(background)
        view.addSubview(tableView)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: view.leftAnchor, right: view.rightAnchor)
        background.anchorY(top: view.topAnchor, bottom: view.bottomAnchor)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.anchorX(left: view.leftAnchor, right: view.rightAnchor)
        tableView.anchorY(top: view.topAnchor, bottom: view.bottomAnchor)
    }
    
    //MARK:- Keyboard Event Handlers
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: self.tableView.contentInset.top, left: self.tableView.contentInset.left, bottom: self.tableView.contentInset.bottom + keyboardSize.height, right: self.tableView.contentInset.right)
            self.tableView.contentInset = contentInsets
            let indexPath = IndexPath(row: todoItems?.count ?? 0, section: 0)
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
    
    //MARK:- Table View Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (todoItems?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < todoItems?.count ?? 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: friendTodoItemCell) as! FriendTodoItemCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: addTodoItemCell) as! AddTodoItemCell
            cell.delegate = self
            return cell
        }
    }
    
    //MARK:- Todo Item Methods
    func addTodoItem(todoItem: TodoItem) {
        print("add todo item")
    }
    func updateTodoItem(cell: TodoItemCell) {
        print("update todo item")
    }
    func removeTodoItem(cell: TodoItemCell) {
        print("remove todo item")
    }


}
