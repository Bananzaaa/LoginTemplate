//
//  RequestsFactory.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 20.12.2020.
//

import Foundation

protocol IRequestsFactory {
    func authCodeRequest() -> GitHubAuthRequest
    func accessTokenRequest(authCode: String) -> GitHubAccessRequest
}

final class RequestsFactory: IRequestsFactory {
    
    func authCodeRequest() -> GitHubAuthRequest {
        return GitHubAuthRequest()
    }
    
    func accessTokenRequest(authCode: String) -> GitHubAccessRequest {
        return GitHubAccessRequest(authCode: authCode)
    }
    
}
