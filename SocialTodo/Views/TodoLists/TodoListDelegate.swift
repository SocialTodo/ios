//
//  TodoListDelegate.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/24/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

protocol TodoListDelegate {
    var todoListsController: TodoListsController { get }
    func addTodoList(todoList: TodoList)
    func updateTodoList(cell: TLCell)
    func removeTodoList(cell: TLCell)
}
