//
//  EmailViewModel.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 19.12.2020.
//

import Foundation

protocol IEmailViewModel: class {
    func signUp(with credentials: EmailCredentials)
    func signIn(with credentials: EmailCredentials)
    var delegate: EmailViewModelDelegate? { get set }
}

protocol EmailViewModelDelegate: class {
    func successSignIn()
    func show(error: Error)
}

final class EmailViewModel: IEmailViewModel {
    private let authService: IAuthService
    
    init(authService: IAuthService) {
        self.authService = authService
    }
    
    // MARK: - IEmailViewModel
    
    weak var delegate: EmailViewModelDelegate?
    
    func signIn(with credentials: EmailCredentials) {
        authService.signIn(using: .email(email: credentials.email,
                                        password: credentials.password)) { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.successSignIn()
            case .failure(let error):
                self?.delegate?.show(error: error)
            }
        }
    }
    
    func signUp(with credentials: EmailCredentials) {
        authService.signUp(using: .email(email: credentials.email,
                                        password: credentials.password)) { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.successSignIn()
            case .failure(let error):
                self?.delegate?.show(error: error)
            }
        }
    }

}

