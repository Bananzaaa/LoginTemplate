//
//  Config.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 20.12.2020.
//

import Foundation

struct Config: Decodable {
    
    // MARK: - GitHub
    
    var githubClientID: String?
    var githubClientSecret: String?
    var githubRedirectURI: String?
    
    // MARK: - Google
    
    var googleClientID: String?
}

