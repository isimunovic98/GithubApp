//
//  DetailsModel.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 05.03.2021..
//

import Foundation
enum DetailsType {
    case author
    case repository
}
struct DetailsModel {
    var title: String
    var webUrl: URL?
    
    init(title: String, webUrl: URL) {
        self.title = title
        self.webUrl = webUrl
    }
    
    init(_ repositryResponseSingle: RepositoryResponseSingle, type: DetailsType ) {
        switch type {
        case .author:
            self.title = repositryResponseSingle.owner.ownerName
            guard let url = URL(string: repositryResponseSingle.htmlUrl) else {
                return
            }
            self.webUrl = url
        case .repository:
            self.title = repositryResponseSingle.name
            guard let url = URL(string: Constants.repositoryUrl(repositryResponseSingle.fullName)) else {
                return
            }
            self.webUrl = url
        }

    }
    
    init(_ githubUser: GithubUser) {
        self.title = githubUser.login
        guard let url = URL(string: githubUser.htmlUrl) else {
            return
        }
        self.webUrl = url
    }
}
