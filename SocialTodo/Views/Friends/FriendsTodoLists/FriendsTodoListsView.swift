//
//  FriendsTodoListsView.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/9/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import UIKit

class FriendsTodoListsView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK:- Properties
    let friend: Friend
    var todoLists: [TodoList]?
    let friendTodoListCell = "FriendTodoListCell"
    
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
    init(friend: Friend) {
        self.friend = friend
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
                
        tableView.register(FriendTodoListCell.self, forCellReuseIdentifier: friendTodoListCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    //MARK:- UI Layout
    func setupLayout() {
        view.addSubview(background)
        view.addSubview(tableView)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: view.leftAnchor, right: view.rightAnchor)
        background.anchorY(top: view.topAnchor, bottom: view.bottomAnchor)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.anchorX(left: view.leftAnchor, leftConstant: 8, right: view.rightAnchor, rightConstant: -8)
        tableView.anchorY(top: view.topAnchor, bottom: view.bottomAnchor)
    }
    
    func setupNavBar() {
        self.navigationItem.title = friend.name
        if let navigationController = navigationController {
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.barTintColor = UIColor(r: 0, g: 154, b: 233)
            navigationController.navigationBar.tintColor = UIColor(r: 199, g: 244, b: 250)
            navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 28) ?? UIFont.boldSystemFont(ofSize: 22), NSAttributedStringKey.foregroundColor: UIColor.white]
        }
    }
    
    //MARK:- UI Button Handlers
    @objc func showFriends() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Table View Methods
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
        let cell = tableView.dequeueReusableCell(withIdentifier: friendTodoListCell, for: indexPath) as! FriendTodoListCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let todoLists = todoLists else {
            return
        }
        let todoList = todoLists[indexPath.row]
        let friendsTodoItemsView = FriendsTodoItemsView(todoList: todoList)
        navigationController?.pushViewController(friendsTodoItemsView, animated: true)
    }
    
}

