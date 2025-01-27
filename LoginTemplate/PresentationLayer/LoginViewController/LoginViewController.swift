//
//  LoginViewController.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 15.12.2020.
//

import UIKit
import GoogleSignIn
import VK_ios_sdk

class LoginViewController: UIViewController {
    
    // MARK: - UI

    private lazy var loginView: LoginView = {
        let loginView = LoginView()
        loginView.delegate = self
        return loginView
    }()
    
    // MARK: - Private
    
    private let presentationAssembly: IPresentationAssembly
    
    // MARK: - Init
    
    init(presentationAssembly: IPresentationAssembly) {
        self.presentationAssembly = presentationAssembly
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Choose login method"
        googleSignInSetup()
        vkSignInSetup()
    }
    
    // MARK: - Helpful
    
    private func googleSignInSetup() {
        guard let config = Bundle.parseConfig(), let clientID = config.googleClientID else {
            print(#line, "No config file or clientID")
            return
        }
        GIDSignIn.sharedInstance().clientID = clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    private func vkSignInSetup() {
        guard let config = Bundle.parseConfig(), let appID = config.vkAppID else {
            print(#line, "No config file or clientID")
            return
        }
        let sdkInstance = VKSdk.initialize(withAppId: appID)
        sdkInstance?.uiDelegate = self
        sdkInstance?.register(self)
    }
    
    private func wakeUpSession() {
        let scope = ["email"]
        VKSdk.wakeUpSession(scope) { (state, error) in
            if state == .authorized {
                //autorized
                print("User authorized")
                
            } else if let error = error {
                print("Error: \(error)")
            } else {
                //autorized neaded
                VKSdk.authorize(scope)
            }
        }
    }

}

extension LoginViewController: LoginViewDelegate {
    func vkButtonTapped() {
        wakeUpSession()
    }
    
    func emailButtonTapped() {
        let vc = presentationAssembly.emailViewController().embedInNavigationController()
        present(vc, animated: true, completion: nil)
    }
    
    func googleButtonTapped() {
        print(#function)
    }
    
    func githubButtonTapped() {
        let vc = presentationAssembly.authWebViewController()
        present(vc.embedInNavigationController(), animated: true, completion: nil)
    }
    
    func fbButtonTapped() {
        print(#function)
    }
}

extension LoginViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print(#line, "The user has not signed in before or they have since signed out.")
            } else {
                print(#line, "\(error.localizedDescription)")
            }
            return
        }
        
//        print("Goole auth user: \(user)")
        
        // Perform any operations on signed in user here.
//        let userId = user.userID                  // For client-side use only!
//        let idToken = user.authentication.idToken // Safe to send to the server
//        let fullName = user.profile.name
//        let givenName = user.profile.givenName
//        let familyName = user.profile.familyName
//        let email = user.profile.email
        // ...
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
      // ...
    }

}

extension LoginViewController: VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}

extension LoginViewController: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult) {
        print(#function)
        if let token = result.token?.accessToken {
            print("VK Access token: \(token)")
        } else {
            print("No accessToken from VK")
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
}

