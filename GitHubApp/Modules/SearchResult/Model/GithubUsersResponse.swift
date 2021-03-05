//
//  GithubUsersResponse.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 05.03.2021..
//

import Foundation

struct GithubUsersResponse: Codable {
    var items: [GithubUser]
}

struct GithubUser: Codable {
    var login: String
    var avatarUrl: String
    var htmlUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
    }
}
