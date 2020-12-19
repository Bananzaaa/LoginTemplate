//
//  ServiceAssembly.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 15.12.2020.
//

import Foundation

protocol IServiceAssembly {
    var authService: IAuthService { get }
}

final class ServiceAssembly {
    private let coreAssembly: ICoreAssembly
    
    init(coreAssembly: ICoreAssembly) {
        self.coreAssembly = coreAssembly
    }
}

extension ServiceAssembly: IServiceAssembly {
    var authService: IAuthService {
        return AuthService(authProvider: coreAssembly.authManager,
                           appSettingsManager: coreAssembly.appSettingsManager)
    }
    
    
}
