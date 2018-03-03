//
//  TodoItemsView.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 1/28/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import UIKit

class TodoItemsView: UIViewController, UITableViewDataSource, UITableViewDelegate, TodoItemDelegate {
    let todoListDelegate: TodoListDelegate
    let todoItemsController = TodoItemsController()
    
    var todoList: TodoList {
        didSet {
            DispatchQueue.main.async {
                self.navigationItem.title = self.todoList.title
            }
        }
    }
    let todoListIndex: Int
    var todoItems: [TodoItem]?
    
    let background: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "TLBackground")
        return iv
    }()
    
    let editButton: UIBarButtonItem = {
        let button = UIButton(type: .system)
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 16)
        button.tintColor = UIColor(r: 199, g: 244, b: 250)
        button.sizeToFit()
        return UIBarButtonItem(customView: button)
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = UIColor.clear
        return tv
    }()
    
    let todoItemCell = "TodoItemCell"
    let addTodoItemCell = "AddTodoItemCell"

    
    init(todoList: TodoList, todoListIndex: Int, todoListDelegate: TodoListDelegate) {
        self.todoList = todoList
        self.todoListIndex = todoListIndex
        self.todoListDelegate = todoListDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupLayout()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(TodoItemCell.self, forCellReuseIdentifier: todoItemCell)
        tableView.register(AddTodoItemCell.self, forCellReuseIdentifier: addTodoItemCell)
        
        todoItemsController.getTodoItems(todoListId: todoList.id!) { (todoItems) in
            self.todoItems = todoItems
            self.tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let editButtonCV = editButton.customView as! UIButton
        editButtonCV.addTarget(self, action: #selector(editTodoList), for: .touchUpInside)
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
        todoListDelegate.didPopTodoItemsView()
    }
    
    @objc func editTodoList() {
        print("edit todo list")
        let createTodoListView = CreateTodoList(todoListDelegate: todoListDelegate)
        createTodoListView.todoList = todoList
        createTodoListView.todoListIndex = todoListIndex
        createTodoListView.todoItemDelegate = self
        let navController = UINavigationController(rootViewController: createTodoListView)
        navController.navigationBar.barTintColor = UIColor(r: 0, g: 154, b: 233)
        navController.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 28) ?? UIFont.boldSystemFont(ofSize: 28), NSAttributedStringKey.foregroundColor: UIColor.white]
        self.present(navController, animated: true, completion: nil)

    }
    
    func setupNavBar() {
        navigationItem.title = todoList.title
        
        if let navigationController = navigationController {
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.barTintColor = UIColor(r: 0, g: 154, b: 233)
            navigationController.navigationBar.tintColor = UIColor(r: 199, g: 244, b: 250)
            navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 32) ?? UIFont.boldSystemFont(ofSize: 28), NSAttributedStringKey.foregroundColor: UIColor.white]
        }
        
        navigationItem.rightBarButtonItem = editButton
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
            let cell = tableView.dequeueReusableCell(withIdentifier: todoItemCell) as! TodoItemCell
            cell.delegate = self
            cell.label.text = todoItems![indexPath.row].title
            cell.todoCheckbox.isChecked = todoItems![indexPath.row].isChecked
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: addTodoItemCell) as! AddTodoItemCell
            cell.delegate = self
            return cell
        }
    }
    
    func addTodoItem(todoItem: TodoItem) {
        todoItems?.append(todoItem)
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            var indexPath = IndexPath(row: self.todoItems!.count - 1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .left)
            self.tableView.endUpdates()
            indexPath = IndexPath(row: self.todoItems!.count, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func updateTodoItem(cell: TodoItemCell){
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        let oldTodoItem = todoItems![indexPath.row]
        let todoItem = TodoItem(id: oldTodoItem.id!, title: cell.label.text!, isChecked: cell.todoCheckbox.isChecked, todoListId: oldTodoItem.todoListId)
        
        todoItemsController.updateTodoItem(todoItem: todoItem) { todoItem in
            self.todoItems![indexPath.row] = todoItem
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func removeTodoItem(cell: TodoItemCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        todoItemsController.removeTodoItem(todoItem: todoItems![indexPath.row]) {
            self.todoItems!.remove(at: indexPath.row)
            DispatchQueue.main.async {
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: .right)
                self.tableView.endUpdates()
            }
        }
    }
}
