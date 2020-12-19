//
//  EmailView.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 16.12.2020.
//

import UIKit

protocol EmailViewDelegate: class {
    func signUp(credentials: EmailCredentials)
    func signIn(credentials: EmailCredentials)
}

final class EmailView: UIView {
    
    // MARK: - UI
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var checkRegistrationButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton! {
        didSet {
            signUpButton.isHidden = true
        }
    }
    @IBOutlet private weak var signInButton: UIButton!
    
    // MARK: - Public
    
    weak var delegate: EmailViewDelegate?
    
    // MARK: - Helpful
    
    private func signButtonsSwitcher() {
        signInButton.isHidden = !signInButton.isHidden
        signUpButton.isHidden = !signUpButton.isHidden
    }
    
    private func checkCredentials() -> EmailCredentials? {
        guard let email = emailTextField?.text, !email.isReallyEmpty,
              let password = passwordTextField?.text, !password.isReallyEmpty else {
            
            let attributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor.red]
            if emailTextField.isEmpty {
                emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: attributes)
            }
            if passwordTextField.isEmpty {
                passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributes)
            }
            return nil
        }
        return EmailCredentials(email: email, password: password)
    }
    
    // MARK: - Actions
    
    @IBAction
    private func actionCheckRegistration(_ sender: Any) {
        signButtonsSwitcher()
    }
    
    @IBAction
    private func actionSignUp(_ sender: UIButton) {
        if let credentials = checkCredentials() {
            delegate?.signUp(credentials: credentials)
        }
    }
    
    @IBAction
    private func actionSignIn(_ sender: UIButton) {
        if let credentials = checkCredentials() {
            delegate?.signIn(credentials: credentials)
        }
    }
    
}
