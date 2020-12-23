//
//  GitHubUserProfileParser.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 21.12.2020.
//

import Foundation

struct GitHubUserProfile: Codable {
    var id: Int?
    var name: String?
    var login: String?
    var email: String?
    var avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case id
        case login
        case email
        case name
    }
}

final class GitHubUserProfileParser: IParser {
    
    func parse(data: Data) -> GitHubUserProfile? {
        do {
            let model = try JSONDecoder().decode(GitHubUserProfile.self, from: data)
            return model
        } catch {
            print(#line, error)
            return nil
        }
    }
}
