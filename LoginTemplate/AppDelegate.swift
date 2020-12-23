//
//  AppDelegate.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 15.12.2020.
//

import UIKit
import Firebase
import FBSDKCoreKit
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let rootAssembly = RootAssembly()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //---Firebase configure---
        
        FirebaseApp.configure()
        
        //---Facebook---
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        //---Entry point---
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        var destVC: UIViewController
        
        //---Check login methods---
        
        if let isSignIn = GIDSignIn.sharedInstance()?.hasPreviousSignIn(), isSignIn {
            print("---SignIn using Google---")
        }
        
        if let token = AccessToken.current, !token.isExpired {
            print("---SignIn using Facebook---")
        }
        
        if let token = AccessToken.current, !token.isExpired {
            destVC = rootAssembly.presentationAssembly.destinationViewController()
        } else {
            destVC = rootAssembly.presentationAssembly.loginViewController()
        }
        
//        destVC = rootAssembly.presentationAssembly.loginViewController()
        
        window?.rootViewController = destVC.embedInNavigationController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        ) {
            return true
        } else {
            return GIDSignIn.sharedInstance().handle(url)
        }
    }

}

