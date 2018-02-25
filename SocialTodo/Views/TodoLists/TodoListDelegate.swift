//
//  TodoListDelegate.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/24/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

protocol TodoListDelegate {
    var todoListsController: TodoListsController { get }
    func didAddTodoList(todoList: TodoList)
    func didRemoveTodoList(cell: TLCell)
    func didUpdateTodoList(todoListIndex: Int, todoList: TodoList)
    func didUpdateTodoListSharing(cell: TLCell)
}
