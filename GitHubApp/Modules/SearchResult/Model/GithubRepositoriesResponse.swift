//
//  RepositorySearchModel.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 04.03.2021..
//

import Foundation

struct GithubRepositoriesResponse: Codable {
    var items: [RepositoryResponseSingle]
}

struct Owner: Codable {
    var ownerName: String
    
    enum CodingKeys: String, CodingKey {
        case ownerName = "login"
    }
}

struct RepositoryResponseSingle: Codable {
    var name: String
    var fullName: String
    var isPrivate: Bool
    var owner: Owner
    var htmlUrl: String
    var description: String?
    var stargazersCount: Int
    var watchersCount: Int
    var forksCount: Int
    var openIssuesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case isPrivate = "private"
        case owner
        case fullName = "full_name"
        case htmlUrl = "html_url"
        case description
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
    }
}
