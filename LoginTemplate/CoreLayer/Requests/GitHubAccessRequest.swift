//
//  GitHubAccessRequest.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 20.12.2020.
//

import Foundation

final class GitHubAccessRequest: IRequest {
    
    private let grantType = "grant_type=" + "authorization_code"
    private let authCode: String
    private let tokenURL = "https://github.com/login/oauth/access_token"
    
    // Set the POST parameters.
//    let postParams = "grant_type=" + grantType + "&code=" + authCode + "&client_id=" + GithubConstants.CLIENT_ID + "&client_secret=" + GithubConstants.CLIENT_SECRET
//    let postData = postParams.data(using: String.Encoding.utf8)
//    let request = URLRequest(url: URL(string: GithubConstants.TOKENURL)!)
//    request.httpMethod = "POST"
//    request.httpBody = postData
//    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    // MARK: - Init
    
    init(authCode: String) {
        self.authCode = authCode
    }
    
    var urlRequest: URLRequest? {
        
        guard let config = Bundle.parseConfig() else {
            print("No config file")
            return nil
        }
        guard let clientID = config.githubClientID,
              let clientSecret = config.githubClientSecret else {
            print("No sensitive data in config file")
            return nil
        }
        
        let fullAuthCode = "&code=\(authCode)"
        let fullClientID = "&client_id=\(clientID)"
        let fullClientSecret = "&client_secret=\(clientSecret)"
        let params = grantType + fullAuthCode + fullClientID + fullClientSecret
        let paramsData = params.data(using: .utf8)
        
        guard let url = URL(string: tokenURL) else {
            print(#line, "Bad URL")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = paramsData
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
    
}
