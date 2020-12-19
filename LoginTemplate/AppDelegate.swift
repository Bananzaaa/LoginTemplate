//
//  AppDelegate.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 15.12.2020.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let rootAssembly = RootAssembly()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //---Firebase configure---
        
        FirebaseApp.configure()
        
        //---Entry point---
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let loginVC = rootAssembly.presentationAssembly.loginViewController().embedInNavigationController()
        window?.rootViewController = loginVC
        window?.makeKeyAndVisible()
        
        return true
    }

}

