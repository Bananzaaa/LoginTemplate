//
//  AuthService.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 15.12.2020.
//

import Foundation

enum AppSettingsKeys: String {
    case isAuthorized
}

protocol IAuthService {
    var isAuthorized: Bool {get}
    func signIn(using loginType: LoginTypes,
               completion: @escaping (Result<Void, Error>) -> Void)
    func signUp(using loginType: LoginTypes,
               completion: @escaping (Result<Void, Error>) -> Void)
}

final class AuthService {
    
    private let authProvider: IAuthManager
    private let appSettingsManager: IAppSettingsManager
    
    init(authProvider: IAuthManager, appSettingsManager: IAppSettingsManager) {
        self.authProvider = authProvider
        self.appSettingsManager = appSettingsManager
    }
}

extension AuthService: IAuthService {
    
    var isAuthorized: Bool {
        if let data = appSettingsManager.getData(for: AppSettingsKeys.isAuthorized.rawValue),
           let stringData = String(data: data, encoding: .utf8),
           let isAuth = Bool(stringData) {
            return isAuth
        }
        return false
    }
    
    func signIn(using loginType: LoginTypes,
                 completion: @escaping (Result<Void, Error>) -> Void) {
        switch loginType {
        case .email(email: let email, password: let password):
            authProvider.signIn(email: email, password: password, completion: completion)
        default:
            break
        }
    }
    
    func signUp(using loginType: LoginTypes,
                 completion: @escaping (Result<Void, Error>) -> Void) {
        switch loginType {
        case .email(email: let email, password: let password):
            authProvider.signUp(withEmail: email, andPassword: password, completion: { [weak self] result in
                switch result {
                case .success:
                    let data = Data(String(describing: true).utf8)
                    self?.appSettingsManager.set(data,
                                                 for: AppSettingsKeys.isAuthorized.rawValue)
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        default:
            break
        }
    }
}
