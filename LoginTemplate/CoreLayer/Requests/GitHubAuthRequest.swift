//
//  GitHubRequest.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 20.12.2020.
//

import Foundation

final class GitHubAuthRequest: IRequest {
    
    private let baseURL = "https://github.com/login/oauth/authorize"
    private let scope = "&scope=" + "read:user,user:email"
    private let tokenURL = "https://github.com/login/oauth/access_token"
    private let state = "&state=\(UUID().uuidString)"
    private let redirectURI = "https://stasatskiy.com"

    var urlRequest: URLRequest? {
        guard let config = Bundle.parseConfig() else {
            print("No config file")
            return nil
        }
        guard let clientID = config.githubClientID else {
            print("No sensitive data in config file")
            return nil
        }
        let fullClientID = "client_id=\(clientID)"
        let fullRedirectUri = "&redirect_uri=\(redirectURI)"
        
        let strUrl = baseURL + "?" + fullClientID + scope + fullRedirectUri + state
        guard let url = URL(string: strUrl) else {
            print(#line, "Bad URL")
            return nil
        }
        return URLRequest(url: url)
    }
    
}
