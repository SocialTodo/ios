//
//  TodoItemsController.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/7/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import FacebookCore

class TodoItemsController {
    func getTodoItems(todoListId: Int, completion: @escaping ([TodoItem]) -> Void) {
        var todoItems = [TodoItem]()
        guard let headers = API.requestHeaders() else {
            return
        }
        let urlRequest = URLRequest(url: "\(API.list)/\(todoListId)", method: "GET", headers: headers)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                return
            }
            guard let responseData = data else {
                return
            }
            do {
                todoItems = try JSONDecoder().decode([TodoItem].self, from: responseData)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                completion(todoItems)
            }
        }
        
        task.resume()
    }
    
    func postTodoItem(todoItem: TodoItem, completion: @escaping (TodoItem) -> Void) {
        guard let headers = API.requestHeaders() else {
            return
        }
        var urlRequest = URLRequest(url: API.item, method: "POST", headers: headers)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let data = try JSONEncoder().encode(todoItem)
            urlRequest.httpBody = data
        } catch {
            print(error)
            return
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                return
            }
            guard let responseData = data else {
                return
            }
            do {
                let todoItemResponse = try JSONDecoder().decode(TodoItem.self, from: responseData)
                completion(todoItemResponse)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func updateTodoItem(todoItem: TodoItem, completion: @escaping (TodoItem) -> Void) {
        guard let headers = API.requestHeaders() else {
            return
        }
        var urlRequest = URLRequest(url: "\(API.item)/\(todoItem.id!)", method: "PATCH", headers: headers)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let data = try JSONEncoder().encode(todoItem)
            urlRequest.httpBody = data
        } catch {
            print(error)
            return
        }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                return
            }
            guard let responseData = data else {
                return
            }
            do {
                let todoItemResponse = try JSONDecoder().decode(TodoItem.self, from: responseData)
                completion(todoItemResponse)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
