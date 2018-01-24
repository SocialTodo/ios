/**
 # AuthControllerInterface

 A protocol that the AppDelegate class conforms to, which allows the application to call methods that typically would
 be called on AuthController to allow the AppController to abstract away these objects.

 */

import UIKit

protocol AuthControllerInterface {
  //Use an implictly unwrapped optional because AppDelegate does not use traditional initializers.
  var authController: AuthController! { get }
  var window: UIWindow? { get }
}

extension AuthControllerInterface {
  /**
   If AccessToken.current is set to nil, this segues to the FacebookLoginViewController.
   */
  public func login() {
//    authController.login()
  }

  /**
   Sets AccessToken.current to nil.
   */
  public func logout() {
    authController.logout()
  }
}
