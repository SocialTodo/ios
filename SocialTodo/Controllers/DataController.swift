/**
 # Database Controller
 
 The object that handles all requests for data outside of the application and returns the data as a Swift object. It can be implemented though the AuthControllerInterface protocol.
 */

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
}
