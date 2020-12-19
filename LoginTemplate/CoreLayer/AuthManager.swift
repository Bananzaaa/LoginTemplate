//
//  AuthManager.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 15.12.2020.
//

import Foundation
import FirebaseAuth

protocol IAuthManager {
    func signUp(withEmail email: String,
                andPassword password: String,
                completion: @escaping (Result<Void, Error>) -> Void)
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<Void, Error>) -> Void)
}

final class AuthManager: IAuthManager {
    
    private let auth = Auth.auth()
    
    func signUp(withEmail email: String,
                andPassword password: String,
                completion: @escaping (Result<Void, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { [weak self] user, error in
            
            if let error = error {
                completion(.failure(error))
                return
            } else {
                self?.signIn(email: email, password: password, completion: completion)
            }
            
        }
    }
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<Void, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            } else {
                completion(.success(()))
            }
        }
    }
    
    
    
}
