//
//  PresentationAssembly.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 15.12.2020.
//

import Foundation

protocol IPresentationAssembly {
    func loginViewController() -> LoginViewController
    func emailViewController() -> EmailViewController
}

final class PresentationAssembly: IPresentationAssembly {
    private let serviceAssembly: IServiceAssembly
    
    init(serviceAssembly: IServiceAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    // MARK: - LoginViewController
    
    func loginViewController() -> LoginViewController {
        return LoginViewController(presentationAssembly: self)
    }
    
    // MARK: - EmailViewController
    
    func emailViewController() -> EmailViewController {
        return EmailViewController(model: emailViewControllerModel)
    }
    
    private var emailViewControllerModel: IEmailViewModel {
        return EmailViewModel(authService: serviceAssembly.authService)
    }
}
