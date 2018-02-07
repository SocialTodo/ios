//
//  TodoListsController.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/7/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import FacebookCore

class TodoListsController {
    func requestHeaders() -> [String: String] {
        // TODO: better error handling
        guard let accessToken = AccessToken.current else {
            return [:]
        }
        let headers = ["user_id": accessToken.userId!, "token": accessToken.authenticationToken, "owner_id": accessToken.userId!]
        return headers
    }
    
    func getMyLists(completion: @escaping ([TodoList]) -> Void) {
        var todoLists = [TodoList]()
        let headers = requestHeaders()
        let url = URL(string: API.list)!
        var urlRequest = URLRequest(url: url)
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
                todoLists = try JSONDecoder().decode([TodoList].self, from: responseData)
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                completion(todoLists)
            }
            
            for todoList in todoLists {
                print(todoList.title)
                // TODO: create entity and save to db
            }
            
        }
        task.resume()
    }
    
    func postTodoList(todoList: TodoList, completion: @escaping (TodoList) -> Void) {
        var headers = requestHeaders()
        let url = URL(string: API.list)!
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"

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
}
