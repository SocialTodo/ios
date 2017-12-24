/**
 # Database Controller
 
 The object that handles all requests for data outside of the application and returns the data as a Swift object. It can be implemented though the DataInterface protocol.
 */

import Alamofire
import FacebookCore
import FacebookLogin

class DataController {
  init() {}
  
  func sendFacebookToken(fbAccessToken: AccessToken) {
    Alamofire.request("https://ihrca.info/api/login", method: .post, parameters: serializableToken(fbAccessToken), encoding: JSONEncoding.default)
  }

  private func serializableToken(_ fbAccessToken: AccessToken) -> Parameters {
    return ["Token": fbAccessToken.authenticationToken, "Expiration": fbAccessToken.expirationDate]
  }
}
