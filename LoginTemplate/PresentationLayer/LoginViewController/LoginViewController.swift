//
//  LoginViewController.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 15.12.2020.
//

import UIKit

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
    }

}

extension LoginViewController: LoginViewDelegate {
    
    func githubButtonTapped() {
        let vc = presentationAssembly.authWebViewController()
        present(vc.embedInNavigationController(), animated: true, completion: nil)
    }
    
    func fbButtonTapped() {
        print(#function)
    }
    
    func emailButtonTapped() {
        let vc = presentationAssembly.emailViewController().embedInNavigationController()
        present(vc, animated: true, completion: nil)
    }
}

