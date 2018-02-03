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
    
    func getMyLists() {
        guard let accessToken = AccessToken.current else {
            print("nil access token")
            return
        }
        let headers: HTTPHeaders = ["user_id": accessToken.userId!, "token": accessToken.authenticationToken, "owner_id": accessToken.userId!]
        
        Alamofire.request("http://localhost:8080/api/list/", method: .get, headers: headers).responseData { (response) in
            guard let data = response.value else {
                print("data not found")
                return
            }

            guard let todoLists = try? JSONDecoder().decode([TodoList].self, from: data) else {
                print("error decoding todoLists")
                return
            }
            
            for todoList in todoLists {
                print(todoList.title)
                // TODO: create entity and save to db
            }
            
        }
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
