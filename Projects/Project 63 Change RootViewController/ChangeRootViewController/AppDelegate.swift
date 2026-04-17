//
//  AppDelegate.swift
//  ChangeRootViewController
//
//  Created by huy on 2023/10/07.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let rootVC = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            window?.rootViewController = rootVC
            window?.makeKeyAndVisible()
            return true
        }
        
        return false
    }

    func changeRootViewController() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let redViewController = mainStoryboard.instantiateViewController(withIdentifier: "RedViewController") as? RedViewController {
            window?.replaceRootViewControllerWith(redViewController, animated: true, completion: nil)
        }
    }
}

