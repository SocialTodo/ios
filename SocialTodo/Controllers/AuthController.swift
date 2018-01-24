/**
 # Authorization Controller
 
 Object that handles getting OAuth tokens and authenticating with servers. It can be implemented though the AuthControllerInterface protocol.
 */

import FacebookCore
import FacebookLogin

class AuthController {
	public func login(success: @escaping () -> Void) {
        LoginManager().logIn(readPermissions: [.publicProfile, .email, .userFriends]) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User canceled login")
            case .success(_, _, let fbAccessToken):
                print("fb logged in")
								success()
//                (UIApplication.shared.delegate as! DataControllerInterface)
//                    .sendFacebookToken(fbAccessToken: fbAccessToken)
            }
        }
    }

    /*private func fetchGraph(user: User) {
     struct UserInfoRequest: GraphRequestProtocol {
     struct Response: GraphResponseProtocol {
     var name: String?
     var email: String?
     var id: String?
     init(rawResponse: Any?) {
     // Decode JSON from rawResponse into other properties here.
     guard let response = rawResponse as? Dictionary<String, Any> else {
     return
     }
     if let name = response["name"] as? String {
     self.name = name
     }
     
     if let id = response["id"] as? String {
     self.id = id
     }
     
     if let email = response["email"] as? String {
     self.email = email
     }
     }
     }
     
     var graphPath = "/me"
     var parameters: [String: Any]? = ["fields": "name, email, id"]
     var accessToken = AccessToken.current
     var httpMethod: GraphRequestHTTPMethod = .GET
     var apiVersion: GraphAPIVersion = .defaultVersion
     }
     
     // initiate facebook graph request
     let connection = GraphRequestConnection()
     connection.add(UserInfoRequest()) { response, result in
     switch result {
     case .success(let response):
     // add user info to firebase database
     var ref: DatabaseReference!
     ref = Database.database().reference()
     let fbID = ref.child("fbID")
     let fbIDUpdate = ["\(response.id!)": "\(user.uid)"]
     fbID.updateChildValues(fbIDUpdate)
     let userRef = ref.child("users/\((user.uid))/")
     let userInfo = ["name": response.name!,
     "email": response.email!]
     userRef.updateChildValues(userInfo)
     case .failed(let error):
     print("User Info Graph Request Failed: \(error)")
     }
     }
     connection.start()
     }*/

    public func logout() {
        LoginManager().logOut()
    }

}
