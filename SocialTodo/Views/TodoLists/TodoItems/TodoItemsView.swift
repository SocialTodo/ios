//
//  TodoItemsView.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 1/28/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import UIKit

class TodoItemsView: UIViewController, UITableViewDataSource, UITableViewDelegate, AddTICellDelegate {

    let todoItemsController = TodoItemsController()
    
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
    
    let todoListId: Int
    var todoItems: [TodoItem]?
    
    let todoItemCell = "TodoItemCell"
    let addTodoItemCell = "AddTodoItemCell"

    
    init(todoListId: Int) {
        self.todoListId = todoListId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationController = navigationController {
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.barTintColor = UIColor(r: 0, g: 154, b: 233)
            navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 32) ?? UIFont.boldSystemFont(ofSize: 28), NSAttributedStringKey.foregroundColor: UIColor.white]
        }
        
        navigationItem.title = "Todo List"
        
        view.addSubview(background)
        view.addSubview(tableView)
        
        setupLayout()

        let leftBarButton: UIBarButtonItem = {
            let button = UIButton(type: .system)
            button.setTitle(" My Lists", for: .normal)
            button.setImage(#imageLiteral(resourceName: "back-chevron"), for: .normal)
            button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 18)
            button.tintColor = UIColor(r: 199, g: 244, b: 250)
            button.addTarget(self, action: #selector(showMyLists), for: .touchUpInside)
            button.sizeToFit()
            let barButton = UIBarButtonItem(customView: button)
            return barButton
        }()
        
        let sharedSwitch: UIBarButtonItem = {
            let sharedSwitch = SharedSwitch()
            sharedSwitch.translatesAutoresizingMaskIntoConstraints = false
            sharedSwitch.size(height: 30, width: 100)
            return UIBarButtonItem(customView: sharedSwitch)
        }()
        
        let editButton: UIBarButtonItem = {
            let button = UIButton(type: .system)
            button.setTitle("Edit", for: .normal)
            button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 16)
            button.tintColor = UIColor(r: 199, g: 244, b: 250)
            button.addTarget(self, action: #selector(editTodoList), for: .touchUpInside)
            button.sizeToFit()
            return UIBarButtonItem(customView: button)
        }()
        
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItems = [editButton, sharedSwitch]

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(TICell.self, forCellReuseIdentifier: todoItemCell)
        tableView.register(AddTICell.self, forCellReuseIdentifier: addTodoItemCell)
        
        todoItemsController.getTodoItems(todoListId: todoListId) { (todoItems) in
            self.todoItems = todoItems
            self.tableView.reloadData()
        }

    }
    
    @objc func showMyLists() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func editTodoList() {
        print("edit todo list")
    }
    
    func setupLayout() {
        background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: view.leftAnchor, right: view.rightAnchor)
        background.anchorY(top: view.topAnchor, bottom: view.bottomAnchor)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.anchorX(left: view.leftAnchor, right: view.rightAnchor)
        tableView.anchorY(top: view.topAnchor, bottom: view.bottomAnchor)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: todoItemCell) as! TICell
            cell.label.text = todoItems![indexPath.row].title
            cell.todoCheckbox.isChecked = todoItems![indexPath.row].isChecked
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: addTodoItemCell) as! AddTICell
            cell.delegate = self
            return cell
        }
    }
    
    func addTodoItem(todoItem: TodoItem) {
        todoItems?.append(todoItem)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
