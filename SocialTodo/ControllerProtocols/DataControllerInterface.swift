//
// Created by Brannen Hall on 17-12-18.
// Copyright (c) 2017 Saatvik Arya. All rights reserved.
//

import UIKit
import FacebookCore

protocol DataControllerInterface {
  //Use an implictly unwrapped optional because AppDelegate does not use traditional initializers.
  var dataController: DataController! { get }
  var window: UIWindow? { get }
}

extension DataControllerInterface {
  func sendFacebookToken(fbAccessToken: AccessToken?) {
		dataController.sendFacebookToken(fbAccessToken: fbAccessToken!)
  }
}
