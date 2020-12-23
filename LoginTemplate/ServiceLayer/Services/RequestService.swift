//
//  RequestService.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 20.12.2020.
//

import Foundation

protocol IRequestService {
    var authCodeRequest: IRequest { get }
    func requestForCallback(with request: URLRequest)
}

final class RequestService {
    
    private let requestFactory: IRequestsFactory
    private let requestSender: IRequestSender
    
    init(requestFactory: IRequestsFactory, requestSender: IRequestSender) {
        self.requestFactory = requestFactory
        self.requestSender = requestSender
    }
    
}

extension RequestService: IRequestService {
    
    var authCodeRequest: IRequest {
        return requestFactory.authCodeRequest()
    }
    
    func requestForCallback(with request: URLRequest) {
        guard let requestStrUrl = request.url?.absoluteString else {return}
        guard requestStrUrl.hasPrefix("https://stasatskiy.com") else { return }
        guard requestStrUrl.contains("code=") else {return}
        let urlComponents = requestStrUrl.components(separatedBy: "=")
        guard urlComponents.count > 1 else {return}
        guard let authCode = urlComponents[1].components(separatedBy: "&").first else {return}
        
        let requestConfig = RequestConfig(request: requestFactory.accessTokenRequest(authCode: authCode),
                                          parser: GitHubAccessTokenParser())
        
        requestSender.send(requestConfig: requestConfig) { [weak self] result in
            switch result {
            case .success(let accessToken):
                print("AccessToken: \(accessToken)")
                self?.fetchUserProfile(accessToken: accessToken,
                                       completion: { _ in })
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchUserProfile(accessToken: String,
                                  completion: @escaping (Result<GitHubUserProfile, Error>) -> Void?) {
        let requestConfig = RequestConfig(request: GitHubFetchProfileRequest(accessToken: accessToken),
                                          parser: GitHubUserProfileParser())
        requestSender.send(requestConfig: requestConfig) { result in
            switch result {
            case .success(let profile):
                print("Profile: \(profile)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
