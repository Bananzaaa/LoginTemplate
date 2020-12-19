//
//  LoginView.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 15.12.2020.
//

import UIKit

protocol LoginViewDelegate: class {
    func emailButtonTapped()
}

final class LoginView: UIView {
    
    // MARK: - UI
    
    @IBOutlet weak var emailButton: UIButton!
    
    // MARK: - LoginViewDelegate
    
    weak var delegate: LoginViewDelegate?
    
    // MARK: - Actions
    
    @IBAction func actionEmail(_ sender: UIButton) {
        delegate?.emailButtonTapped()
    }
    
}
