//
//  Constants.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 05.03.2021..
//

import Foundation

struct Constants {
    static func getRepositories(of query: String) -> String {
        return "https://api.github.com/search/repositories?q=\(query)"
    }
    
    static func getUsers(of query: String) -> String {
        return "https://api.github.com/search/users?q=\(query)"
    }
    
    static func repositoryUrl(_ string: String) -> String {
        return "https://github.com/\(string)"
    }
    
    static func allRepositories(of userName: String) -> String {
        return "https://github.com/\(userName)?tab=repositories"
    }
}
