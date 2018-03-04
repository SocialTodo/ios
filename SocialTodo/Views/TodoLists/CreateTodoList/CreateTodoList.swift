//
//  CreateTodoList.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/23/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import UIKit

class CreateTodoList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK:- Properties
    let todoListDelegate: TodoListDelegate
    var todoItemDelegate: TodoItemDelegate?
    
    var todoList: TodoList? {
        didSet {
            titleField.textField.text = todoList?.title
            sharingSwitch.isShared = todoList?.isShared
        }
    }
    var todoListIndex: Int?
    var friends: [Friend]?
    let friendCell = "friendCell"
    let addFriendCell = "addFriendCell"
    
    //MARK:- UI Elements
    let background: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "TLBackground")
        return iv
    }()
    
    let titleField: TitleField = {
        let tf = TitleField()
        return tf
    }()
    
    let sharingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 24)
        label.textColor = .white
        label.text = "Sharing"
        return label
    }()
    
    let sharingSwitch: SharedSwitch = {
        let ss = SharedSwitch()
        return ss
    }()
    
    let sharingInfo: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Regular", size: 14)
        label.textColor = .white
        label.numberOfLines = 2
        label.text = "The Todo List is shared with all your friends by default. \nShare with a group of friends by adding them below"
        return label
    }()
    
    let friendsTableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = UIColor.clear
        return tv
    }()
    
    //MARK:- Init
    init(todoListDelegate: TodoListDelegate) {
        self.todoListDelegate = todoListDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = todoList?.title ?? "Create Todo List"
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        cancelButton.tintColor = UIColor(r: 199, g: 240, b: 250)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handleDone))
        doneButton.tintColor = UIColor(r: 199, g: 240, b: 250)
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
        
        setupLayout()
        
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        
        friendsTableView.register(AddFriendCell.self, forCellReuseIdentifier: addFriendCell)
        friendsTableView.register(FriendCell.self, forCellReuseIdentifier: friendCell)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        sharingSwitch.button.addTarget(self, action: #selector(handleSharedSwitch), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    //MARK:- UI Button Handlers
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
        print("handle cancel")
    }
    
    @objc func handleDone() {
        guard let title = titleField.textField.text else {
            return
        }
        guard let isShared = sharingSwitch.isShared else {
            return
        }
        if var todoList = self.todoList {
            guard let id = todoList.id else {
                return
            }
            todoList = TodoList(id: id, title: title, isShared: isShared)
            todoListDelegate.todoListsController.updateTodoList(todoList: todoList, completion: { (todoList) in
                self.todoListDelegate.didUpdateTodoList(todoListIndex: self.todoListIndex!, todoList: todoList)
                self.todoItemDelegate?.todoList = todoList
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            let todoList = TodoList(id: nil, title: title, isShared: isShared)
            todoListDelegate.todoListsController.postTodoList(todoList: todoList) { (todoList) in
                self.todoListDelegate.didAddTodoList(todoList: todoList)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func handleSharedSwitch() {
        if sharingSwitch.isShared {
            sharingSwitch.button.isEnabled = false
            sharingSwitch.isShared = false
            sharingSwitch.button.isEnabled = true
        } else {
            sharingSwitch.button.isEnabled = false
            sharingSwitch.isShared = true
            sharingSwitch.button.isEnabled = true
        }
    }
    
    //MARK:- Keyboard Event Handlers
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: self.friendsTableView.contentInset.top, left: self.friendsTableView.contentInset.left, bottom: self.friendsTableView.contentInset.bottom + keyboardSize.height, right: self.friendsTableView.contentInset.right)
            self.friendsTableView.contentInset = contentInsets
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: self.friendsTableView.contentInset.top, left: self.friendsTableView.contentInset.left, bottom: self.friendsTableView.contentInset.bottom - keyboardSize.height, right: self.friendsTableView.contentInset.right)
            self.friendsTableView.contentInset = contentInsets
            self.friendsTableView.scrollIndicatorInsets = contentInsets
        }
    }
    
    //MARK:- Table View Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (friends?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < friends?.count ?? 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: friendCell, for: indexPath) as! FriendCell
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: addFriendCell, for: indexPath) as! AddFriendCell
            return cell
        }
    }
    
    //MARK:- UI Layout
    func setupLayout() {
        view.addSubview(background)
        view.addSubview(titleField)
        view.addSubview(sharingLabel)
        view.addSubview(sharingSwitch)
        view.addSubview(sharingInfo)
        view.addSubview(friendsTableView)
        
        let margins = view.layoutMarginsGuide
        
        background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: view.leftAnchor, right: view.rightAnchor)
        background.anchorY(top: view.topAnchor, bottom: view.bottomAnchor)
        
        titleField.translatesAutoresizingMaskIntoConstraints = false
        titleField.size(height: 50)
        titleField.anchorX(left: view.leftAnchor, leftConstant: 8, right: view.rightAnchor, rightConstant: -8)
        titleField.anchorY(top: margins.topAnchor, topConstant: 12)
        
        sharingLabel.translatesAutoresizingMaskIntoConstraints = false
        sharingLabel.size(height: 40)
        sharingLabel.anchorX(left: view.leftAnchor, leftConstant: 10)
        sharingLabel.anchorY(top: titleField.bottomAnchor, topConstant: 8)
        
        sharingSwitch.translatesAutoresizingMaskIntoConstraints = false
        sharingSwitch.anchorX(right: view.rightAnchor, rightConstant: -8)
        sharingSwitch.centerYAnchor.constraint(equalTo: sharingLabel.centerYAnchor).isActive = true
        sharingSwitch.size(height: 30, width: 100)
        
        sharingInfo.translatesAutoresizingMaskIntoConstraints = false
        sharingInfo.anchorX(left: view.leftAnchor, leftConstant: 8, right: view.rightAnchor, rightConstant: -8)
        sharingInfo.size(height: 40)
        sharingInfo.anchorY(top: sharingLabel.bottomAnchor, topConstant: 8)
        
        friendsTableView.translatesAutoresizingMaskIntoConstraints = false
        friendsTableView.anchorX(left: view.leftAnchor, leftConstant: 8, right: view.rightAnchor, rightConstant: -8)
        friendsTableView.anchorY(top: sharingInfo.bottomAnchor, topConstant: 8, bottom: margins.bottomAnchor, bottomConstant: -18)
    }
}
