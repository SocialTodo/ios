/**
 # JSON List

 A JSONItem that holds other JSONItems. Since it is a JSONItem itself, it also conforms to the Codable protocol.
*/

protocol JSONObject: JSONItem {
  associatedtype Item: JSONItem
  // The jsonObjects variable represents the collection of JSONItems it holds.
  var jsonObjects: [Item] { get set }
  /* An optional objectID parameter on the list element — If a JSONListElement is created within the application, it will not have an ID until
   it is uploaded to the server, and having objectID equal to nil will suggest to the server that this is a new Todo. On the otherhand, if the Todo
   is not new and already exsists in the database, having objectID set to the database's keyvalue for the JSONListElement object will allow the server
   to identify what object it should change. */
  var objectID: JSONItem.ObjectID? { get }
}

extension JSONObject {
  mutating public func add(item: Item) {
    jsonObjects.append(item)
  }

  mutating public func add(items: [Item]) {
    for item in items {
      jsonObjects.append(item)
    }
  }

  /**
   Removes the current element at an index in the list and then reindexes the list.

   Warning: If one element is removed, Swift will automatically
   reindex the others, so further removes should not be permitted
   until tableView recieves new, properly indexed elements
   */
  mutating public func remove(index: Int) {
    jsonObjects.remove(at: index)
  }

  mutating public func remove(element: Item) -> Bool {
    for index in 0...jsonObjects.count where element == jsonObjects[index] {
      jsonObjects.remove(at: index)
      return true
    }
    return false
  }

  public func getElement(index: Int) -> Item {
    return jsonObjects[index]
  }

  // This should always return an array of strings
  public func getElements() -> [Item] {
    return jsonObjects
  }

  mutating public func empty() {
    jsonObjects = []
  }
}
