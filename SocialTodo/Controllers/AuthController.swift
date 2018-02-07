/**
# Authorization Controller

Object that handles getting OAuth tokens and authenticating with servers. It can be implemented though the AuthControllerInterface protocol.
*/

import FacebookCore
import FacebookLogin

class AuthController {
    var facebookToken: AccessToken? {
        get {
            return AccessToken.current
        }
        set {
            AccessToken.current = newValue
        }
    }
    
    // get token from userdefaults
    func fetchStoredToken() {
        if let facebookAccessToken = UserDefaults.standard.dictionary(forKey: "facebookAccessToken") {
            facebookToken = createAccessToken(with: facebookAccessToken)
            print("auth token: ", facebookToken?.authenticationToken)
            AccessToken.refreshCurrentToken()
        }
    }
    
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

	public func logout() {
		LoginManager().logOut()
	}

}
