//
//  TodoListsController.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/7/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import Foundation

class TodoListsController {
    
    func getMyLists(completion: @escaping ([TodoList]) -> Void) {
        var todoLists = [TodoList]()
        guard let headers = API.requestHeaders() else {
            return
        }
        
        let urlRequest = URLRequest(url: API.list, method: "GET", headers: headers)
        
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
                todoLists = try JSONDecoder().decode([TodoList].self, from: responseData)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                completion(todoLists)
            }
        }
        task.resume()
    }
    
    func postTodoList(todoList: TodoList, completion: @escaping (TodoList) -> Void) {
        guard let headers = API.requestHeaders() else {
            return
        }
        var urlRequest = URLRequest(url: API.list, method: "POST", headers: headers)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let data = try JSONEncoder().encode(todoList)
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
                let todoListResponse = try JSONDecoder().decode(TodoList.self, from: responseData)
                completion(todoListResponse)
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
    func updateTodoList(todoList: TodoList, completion: @escaping (TodoList) -> Void) {
        guard let headers = API.requestHeaders() else {
            return
        }
        var urlRequest = URLRequest(url: "\(API.list)/\(todoList.id!)", method: "PATCH", headers: headers)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let data = try JSONEncoder().encode(todoList)
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
                let todoListResponse = try JSONDecoder().decode(TodoList.self, from: responseData)
                completion(todoListResponse)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func removeTodoList(todoList: TodoList, completion: @escaping () -> Void) {
        guard let headers = API.requestHeaders() else {
            return
        }
        let urlRequest = URLRequest(url: "\(API.list)/\(todoList.id!)", method: "DELETE", headers: headers)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                return
            }
            completion()
        }
        task.resume()
    }
    
    
}
