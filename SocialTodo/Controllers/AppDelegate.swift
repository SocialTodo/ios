/**
 # App Delegat

 */

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, DataControllerInterface, AuthControllerInterface {

  var window: UIWindow?
  var dataController: DataController!
  var authController: AuthController!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    dataController = DataController()
    authController = AuthController()
    login()
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {

  }

  func applicationDidEnterBackground(_ application: UIApplication) {

  }

  func applicationWillEnterForeground(_ application: UIApplication) {

  }

  func applicationDidBecomeActive(_ application: UIApplication) {

  }

  func applicationWillTerminate(_ application: UIApplication) {

  }

}