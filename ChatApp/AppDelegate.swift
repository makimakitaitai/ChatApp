//
//  AppDelegate.swift
//  ChatApp
//
//  Created by 萬木大志 on 2020/02/12.
//  Copyright © 2020 makimaki. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
final internal class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LoginViewController()
        // window?.rootViewController = NavigationController(rootViewController: LaunchViewController())
        window?.makeKeyAndVisible()
        
        if UserDefaults.isFirstLaunch() {
            // Enable Text Messages
            UserDefaults.standard.set(true, forKey: "Text Messages")
        }
        
        return true
    }

}
