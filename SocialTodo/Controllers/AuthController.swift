/**
# Authorization Controller

Object that handles getting OAuth tokens and authenticating with servers. It can be implemented though the AuthControllerInterface protocol.
*/

import FacebookCore
import FacebookLogin
import Alamofire

class AuthController {
	public func login(success: @escaping () -> Void) {
		LoginManager().logIn(readPermissions: [.publicProfile, .email, .userFriends]) { (loginResult) in
			switch loginResult {
			case .failed(let error):
				print(error)
			case .cancelled:
				print("User canceled login")
            case .success(let grantedPermissions, let declinedPermissions, let token):
				print("fb logged in")
                self.storeAccessToken(grantedPermissions: grantedPermissions, declinedPermissions: declinedPermissions, token: token)
				success()
				//(UIApplication.shared.delegate as! DataControllerInterface)
				//.sendFacebookToken(fbAccessToken: fbAccessToken)
			}
		}
	}
    
    public func createAccessToken(with facebookAccessToken: [String: Any]) -> AccessToken {
        let appId = facebookAccessToken["appId"] as! String
        let authenticationToken = facebookAccessToken["authToken"] as! String
        let userId = facebookAccessToken["userId"] as! String?
        let refreshDate = facebookAccessToken["refreshDate"] as! Date
        let expirationDate = facebookAccessToken["expirationDate"] as! Date
        let grantedPermissionsArray = facebookAccessToken["grantedPermissions"] as! [String]
        let declinedPermissionsArray = facebookAccessToken["declinedPermissions"] as! [String]
        
        var grantedPermissions = Set<Permission>()
        for permission in grantedPermissionsArray {
            grantedPermissions.insert(Permission(name: permission))
        }
        
        var declinedPermissions = Set<Permission>()
        for permission in declinedPermissionsArray {
            declinedPermissions.insert(Permission(name: permission))
        }
        
        
        let token = AccessToken.init(appId: appId, authenticationToken: authenticationToken, userId: userId, refreshDate: refreshDate, expirationDate: expirationDate, grantedPermissions: grantedPermissions, declinedPermissions: declinedPermissions)
        
        return token
    }
    
    public func storeAccessToken(grantedPermissions: Set<Permission>, declinedPermissions: Set<Permission>, token: AccessToken) {
        var grantedPermissionsArray = [String]()
        for permission in grantedPermissions {
            grantedPermissionsArray.append(permission.name)
        }
        var declinedPermissionsArray = [String]()
        for permission in declinedPermissions {
            declinedPermissionsArray.append(permission.name)
        }
        UserDefaults.standard.setValuesForKeys(["facebookAccessToken": ["appId" : token.appId,
                                                                        "authToken": token.authenticationToken,
                                                                        "userId": token.userId,
                                                                        "refreshDate": token.refreshDate,
                                                                        "expirationDate": token.expirationDate,
                                                                        "grantedPermissions": grantedPermissionsArray,
                                                                        "declinedPermissions": declinedPermissionsArray]])
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
