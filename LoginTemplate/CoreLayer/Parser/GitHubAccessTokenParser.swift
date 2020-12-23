//
//  GitHubParser.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 20.12.2020.
//

import Foundation

struct GitHubResponse: Codable {
    var accessToken: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}

final class GitHubAccessTokenParser: IParser {
    
    func parse(data: Data) -> String? {
        do {
            let model = try JSONDecoder().decode(GitHubResponse.self, from: data)
            return model.accessToken
        } catch {
            print(error)
            return nil
        }
    }
    
}
