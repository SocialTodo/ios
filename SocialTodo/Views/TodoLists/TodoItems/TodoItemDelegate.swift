//
//  TodoItemDelegate.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/24/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import Foundation

protocol TodoItemDelegate {
    var todoItemsController: TodoItemsController { get }
    var todoList: TodoList { get }
    func addTodoItem(todoItem: TodoItem)
    func updateTodoItem(cell: TICell)
    func removeTodoItem(cell: TICell)
}
