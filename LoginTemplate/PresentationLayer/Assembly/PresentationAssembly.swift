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
    func destinationViewController() -> DestinationViewController
    func authWebViewController() -> AuthWebViewController
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
    
    // MARK: - DestinationViewController
    
    func destinationViewController() -> DestinationViewController {
        return DestinationViewController()
    }
    
    // MARK: - Auth
    
    func authWebViewController() -> AuthWebViewController {
        return AuthWebViewController(requestService: serviceAssembly.requestService)
    }
}
