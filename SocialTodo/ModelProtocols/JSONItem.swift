/**
 # JSON Item

 This protocol represents an object that is to be later converted to JSON.
 All implementing classes therefore are able to be coded and decoded into JSON.
*/
import Foundation

protocol JSONItem: Equatable, Codable {
  typealias ObjectID = String
  /* An optional objectID parameter on the list element — If a JSONListElement is created within the application, it will not have an ID until
  it is uploaded to the server, and having objectID equal to nil will suggest to the server that this is a new Todo. On the otherhand, if the Todo
  is not new and already exsists in the database, having objectID set to the database's keyvalue for the JSONListElement object will allow the server
  to identify what object it should change. */
  var objectID: ObjectID? { get }
}

extension JSONItem {
  /**
    Asserts that two JSONListElements are equal if they have the same objectID.
    If either element does not have an objectID, the expression returns false.

    - Returns: A Bool that asserts that both JSONListElement's objectID's are not nil and they have equal objectID's.
  */
  static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.objectID != nil && lhs.objectID == rhs.objectID
  }
}
