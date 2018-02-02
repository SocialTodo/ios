//
//  TodoItemsViewController.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 1/28/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import UIKit

class TodoItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    
    
    let todoItemCell = "TodoItemCell"
    
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
        
//        let rightBarButton: UIBarButtonItem = {
//            let view = UIView()
//            let sharedSwitch = SharedSwitch()
//            view.addSubview(sharedSwitch)
//
//            let button = UIButton(type: .system)
//            button.setTitle("Edit", for: .normal)
//            button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 16)
//            button.tintColor = UIColor(r: 199, g: 244, b: 250)
//            button.addTarget(self, action: #selector(editTodoList), for: .touchUpInside)
//            button.sizeToFit()
//
//            view.addSubview(button)
//
//            sharedSwitch.translatesAutoresizingMaskIntoConstraints = false
//            sharedSwitch.anchorX(left: view.leftAnchor, right: button.leftAnchor, rightConstant: -8)
//            sharedSwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//            sharedSwitch.size(height: 30, width: 100)
//
//            button.translatesAutoresizingMaskIntoConstraints = false
//            button.anchorX(left: sharedSwitch.rightAnchor, leftConstant: 8, right: view.rightAnchor)
//            button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//
//            let barButton = UIBarButtonItem(customView: view)
//            return barButton
//        }()
        
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: todoItemCell)!
        return cell
    }
    
}
