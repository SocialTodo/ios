/**
 # Database Controller
 
 The object that handles all requests for data outside of the application and returns the data as a Swift object. It can be implemented though the AuthControllerInterface protocol.
 */

import Alamofire
import FacebookCore
import FacebookLogin

class DataController {
  init() {}

	func sendFacebookToken(fbAccessToken: AccessToken) {
		// WARNING: DO NOT RUN IN PRODUCTION UNTIL SSL IS CONFIGURED!
		// REMOVE EXEMPTION FROM Info.plist TO TEST
		Alamofire.request("http://ihrca.info:1337/api/login", method: .post, parameters: fbAccessToken.serializableToken(), encoding: URLEncoding.default)
		// Switch to JSONEncoding.default
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
