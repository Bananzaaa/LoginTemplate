//
//  CoreAssembly.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 15.12.2020.
//

import Foundation

protocol ICoreAssembly {
    var authManager: IAuthManager { get }
    var appSettingsManager: IAppSettingsManager { get }
    var requestsFactory: IRequestsFactory { get }
    var requestSender: IRequestSender { get }
}

final class CoreAssembly: ICoreAssembly {
    var authManager: IAuthManager {
        return AuthManager()
    }
    
    lazy var appSettingsManager: IAppSettingsManager = {
        return AppSettingsManager()
    }()
    
    var requestsFactory: IRequestsFactory {
        return RequestsFactory()
    }
    
    var requestSender: IRequestSender {
        return RequestSender(session: URLSession.shared, httpClient: httpClient)
    }
    
    private var httpClient: IHTTPClient {
        return HTTPClient()
    }
    
}
