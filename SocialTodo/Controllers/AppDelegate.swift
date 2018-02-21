/**
 # App Delegat
 
 */

import UIKit
import FacebookCore
import FacebookLogin

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Initial View Setup
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MasterView()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    // Allow opening facebook urls with facebook app
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return SDKApplicationDelegate.shared.application(app, open: url, options: options)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        AppEventsLogger.activate()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
}
