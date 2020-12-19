//
//  EmailViewController.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 16.12.2020.
//

import UIKit

class EmailViewController: UIViewController {
    
    // MARK: - UI
    
    lazy var emailView: EmailView = {
        let emailView: EmailView = EmailView.loadFromNib()
        emailView.delegate = self
        return emailView
    }()
    
    // MARK: - Private
    
    private let model: IEmailViewModel
    
    // MARK: - Init
    
    init(model: IEmailViewModel) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = emailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        model.delegate = self
    }
    
    // MARK: - Helphul
    
    private func setupNavBar() {
        title = "Sign in with email"
        let closeBarButton = UIBarButtonItem(title: "Close",
                                             style: .done,
                                             target: self,
                                             action: #selector(actionClose))
        navigationItem.rightBarButtonItem = closeBarButton
    }
    
    // MARK: - Actions
    
    @objc
    private func actionClose() {
        dismiss(animated: true, completion: nil)
    }

}

extension EmailViewController: EmailViewDelegate {

    func signUp(credentials: EmailCredentials) {
        model.signUp(with: credentials)
    }
    
    func signIn(credentials: EmailCredentials) {
        model.signIn(with: credentials)
    }
}

extension EmailViewController: EmailViewModelDelegate {
    func successSignIn() {
        let alert = UIAlertController(title: "Success",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func show(error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
