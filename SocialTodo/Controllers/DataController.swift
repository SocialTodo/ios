/**
 # Database Controller
 
 The object that handles all requests for data outside of the application and returns the data as a Swift object. It can be implemented though the AuthControllerInterface protocol.
 */

import Alamofire
import FacebookCore
import FacebookLogin
import Fluent
import Foundation

class DataController {
    let database: Database
    
    init() {
        let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("db").appendingPathExtension("sqlite3")
        print(documentDirectory.path)
        let driver = try! SQLiteDriver(path: documentDirectory.path)
         self.database = Fluent.Database(driver)
        print("database created")
        databasePreparations()
        print("database prepared")
    }
    
    func databasePreparations() {
        do {
            try database.prepare([FacebookUser.self, TodoListEntity.self, TodoItemEntity.self])
        } catch {
            print(error)
        }
    }
    
    func getMyLists(completion: @escaping ([TodoList]) -> Void) {
        
        var todoLists = [TodoList]()
        let headers = getRequestHeaders()
        var urlRequest: URLRequest
        do {
            urlRequest = try URLRequest(url: API.list, method: .get, headers: headers)
        } catch {
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
        var headers = getRequestHeaders()
        headers["Content-Type"] = "application/json"
        var urlRequest: URLRequest
        do {
            urlRequest = try URLRequest(url: API.list, method: .post, headers: headers)
            let data = try JSONEncoder().encode(todoList)
            urlRequest.httpBody = data
        } catch {
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
    
    func getTodoItems(todoListId: Int, completion: @escaping ([TodoItem]) -> Void) {
        var todoItems = [TodoItem]()
        let headers = getRequestHeaders()
        var urlRequest: URLRequest
        do {
            urlRequest = try URLRequest(url: "\(API.list)/\(todoListId)", method: .get, headers: headers)
        } catch {
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
        var headers = getRequestHeaders()
        headers["Content-Type"] = "application/json"
        var urlRequest: URLRequest
        do {
            urlRequest = try URLRequest(url: API.item, method: .post, headers: headers)
            let data = try JSONEncoder().encode(todoItem)
            urlRequest.httpBody = data
        } catch {
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
    
    func getRequestHeaders() -> HTTPHeaders {
        let accessToken = AccessToken.current!
        let headers: HTTPHeaders = ["user_id": accessToken.userId!, "token": accessToken.authenticationToken, "owner_id": accessToken.userId!]
        return headers
    }
}
