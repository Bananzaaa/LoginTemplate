//
//  GitHubFetchProfileRequest.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 21.12.2020.
//

import Foundation

final class GitHubFetchProfileRequest: IRequest {
    
    private let stringUrl = "https://api.github.com/user"
    private let accessToken: String
    
    
    // MARK: - Init
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: stringUrl) else {
            print(#line, "Bad URL")
            return nil
        }
        let fullAccessToken = "Bearer " + accessToken
        var request = URLRequest(url: url)
        request.addValue(fullAccessToken, forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    
}
