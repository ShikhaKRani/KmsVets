//
//  AppDelegate.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 12/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var latestProductArray : [[String: Any]] = [[:]]
    var currentTab : String?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        
        let USERID = UserDefaults.standard.string(forKey: "id")
        
        if USERID == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
            let navController = UINavigationController.init(rootViewController: vc)
            self.window?.rootViewController = navController
        }
        else {
            let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            let navController = UINavigationController.init(rootViewController: vc)
            self.window?.rootViewController = navController
        }
        
        return true
    }
    
}

