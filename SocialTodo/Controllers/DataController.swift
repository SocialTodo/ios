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
    
    func sendFacebookToken(fbAccessToken: AccessToken) {
        // WARNING: DO NOT RUN IN PRODUCTION UNTIL SSL IS CONFIGURED!
        // REMOVE EXEMPTION FROM Info.plist TO TEST
        Alamofire.request("http://ihrca.info:1337/api/login", method: .post, parameters: fbAccessToken.serializableToken(), encoding: URLEncoding.default)
        // Switch to JSONEncoding.default
    }
    
    func getMyLists(completion: @escaping ([TodoList]) -> Void) {
        
        var todoLists = [TodoList]()
        let headers = getRequestHeaders()
        var urlRequest: URLRequest
        do {
            urlRequest = try URLRequest(url: "http://localhost:8080/api/list/", method: .get, headers: headers)
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

    func postTodoList(todoList: TodoList) {
        var headers = getRequestHeaders()
        headers["Content-Type"] = "application/json"
        var urlRequest: URLRequest
        do {
            urlRequest = try URLRequest(url: "http://localhost:8080/api/list", method: .post, headers: headers)
            let data = try JSONEncoder().encode(todoList)
            urlRequest.httpBody = data
        } catch {
            return
        }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            // TODO: handle error and response
            print(data)
            print(response)
            print(error)
        }
        task.resume()
    }
    
    func getTodoItems(todoListId: Int, completion: @escaping ([TodoItem]) -> Void) {
        var todoItems = [TodoItem]()
        let headers = getRequestHeaders()
        var urlRequest: URLRequest
        do {
            urlRequest = try URLRequest(url: "http://localhost:8080/api/list/\(todoListId)", method: .get, headers: headers)
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
    
    func postTodoItem(todoItem: TodoItem) {
        var headers = getRequestHeaders()
        headers["Content-Type"] = "application/json"
        var urlRequest: URLRequest
        do {
            urlRequest = try URLRequest(url: "http://localhost:8080/api/item/", method: .post, headers: headers)
            let data = try JSONEncoder().encode(todoItem)
            urlRequest.httpBody = data
        } catch {
            return
        }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            // TODO: handle error and response
            print(data)
            print(response)
            print(error)
        }
        
        task.resume()
    }
    
    func getRequestHeaders() -> HTTPHeaders {
        let accessToken = AccessToken.current!
        let headers: HTTPHeaders = ["user_id": accessToken.userId!, "token": accessToken.authenticationToken, "owner_id": accessToken.userId!]
        return headers
    }
}

extension AccessToken {
    func serializableToken() -> Parameters {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return [
            "UserID": userId ?? "ERROR: No UserID provided by token",
            "Token": authenticationToken,
            "Expiration": dateFormatter.string(from: expirationDate)
        ]
    }
}
