//
//  TodoItemsController.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/7/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import FacebookCore

class TodoItemsController {
    func requestHeaders() -> [String: String] {
    // TODO: better error handling
    guard let accessToken = AccessToken.current else {
        return [:]
    }
    let headers = ["user_id": accessToken.userId!, "token": accessToken.authenticationToken, "owner_id": accessToken.userId!]
    return headers
    }
    
    func getTodoItems(todoListId: Int, completion: @escaping ([TodoItem]) -> Void) {
        var todoItems = [TodoItem]()
        let headers = requestHeaders()
        var urlRequest: URLRequest
        let url = URL(string: "\(API.list)/\(todoListId)")!
        urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = "GET"
        
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
            
            for todoItem in todoItems {
                print(todoItem.title)
                // TODO: create entity and save to db
            }
            
        }
        
        task.resume()
    }
    
    func postTodoItem(todoItem: TodoItem, completion: @escaping (TodoItem) -> Void) {
        var headers = requestHeaders()
        let url = URL(string: API.item)!
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
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
