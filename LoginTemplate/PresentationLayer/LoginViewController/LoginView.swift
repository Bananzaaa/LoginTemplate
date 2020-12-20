//
//  LoginView.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 15.12.2020.
//

import UIKit
import SnapKit
import FBSDKLoginKit

protocol LoginViewDelegate: class {
    func emailButtonTapped()
    func fbButtonTapped()
}

final class LoginView: UIView {
    
    // MARK: - UI
    
    private lazy var emailButton: UIButton = {
        let btn = UIButton.loginButton(title: "Email",
                                       color: .green,
                                       action: #selector(self.actionEmail(_:)))
        return btn
    }()
    
    private lazy var fbButton: FBLoginButton = {
        let btn = FBLoginButton()
        btn.permissions = ["public_profile", "email"]
        return btn
    }()
        
    private lazy var buttonsStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [emailButton, fbButton])
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
    
}
