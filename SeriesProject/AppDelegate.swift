//
//  AppDelegate.swift
//  SeriesProject
//
//  Created by Dağhan Kılıçay on 12.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        makeApplicationEnvironmentConfiguration()
        return true
    }
    
    func makeApplicationEnvironmentConfiguration() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let rootViewController = HomeVC()
        window?.rootViewController = rootViewController
    }
}

