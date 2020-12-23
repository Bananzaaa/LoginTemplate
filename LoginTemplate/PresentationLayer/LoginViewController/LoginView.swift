//
//  LoginView.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 15.12.2020.
//

import UIKit
import SnapKit
import FBSDKLoginKit
import GoogleSignIn

protocol LoginViewDelegate: class {
    func emailButtonTapped()
    func fbButtonTapped()
    func githubButtonTapped()
    func googleButtonTapped()
    func vkButtonTapped()
}

final class LoginView: UIView {
    
    // MARK: - UI
    
    private lazy var emailButton: UIButton = {
        return UIButton.loginButton(title: "Log in with Email",
                                    color: .green,
                                    action: #selector(self.actionEmail(_:)))
    }()
    
    private lazy var fbButton: FBLoginButton = {
        let btn = FBLoginButton()
        btn.permissions = ["public_profile", "email"]
        return btn
    }()
    
    private lazy var githubButton: UIButton = {
        return UIButton.loginButton(title: "Log in with GitHub",
                                    color: .darkGray,
                                    action: #selector(self.actionGitHub(_:)))
    }()
    
    private lazy var googleButton: GIDSignInButton = {
        let btn = GIDSignInButton()
        btn.style = .standard
        btn.colorScheme = .light
        return btn
    }()
    
    private lazy var vkButton: UIButton = {
        return UIButton.loginButton(title: "Log in with VK",
                                    color: .systemBlue,
                                    action: #selector(self.actionVK(_:)))
    }()
        
    private lazy var buttonsStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            emailButton,
            fbButton,
            githubButton,
            googleButton,
            vkButton,
        ])
        sv.alignment = .fill
        sv.distribution = .fill
        sv.axis = .vertical
        sv.spacing = 10
        addSubview(sv)
        return sv
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        buttonsStack.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LoginViewDelegate
    
    weak var delegate: LoginViewDelegate?
    
    // MARK: - Actions
    
    @objc
    private func actionEmail(_ sender: UIButton) {
        delegate?.emailButtonTapped()
    }
    
    @objc
    private func actionFb(_ sender: UIButton) {
        delegate?.fbButtonTapped()
    }
    
    @objc
    private func actionGitHub(_ sender: UIButton) {
        delegate?.githubButtonTapped()
    }
    
    @objc
    private func actionVK(_ sender: UIButton) {
        delegate?.vkButtonTapped()
    }
    
}
