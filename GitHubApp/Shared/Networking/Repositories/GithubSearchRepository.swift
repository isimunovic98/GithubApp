//
//  GithubRepositoriesRepository.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 05.03.2021..
//

import Foundation
import Combine

protocol GithubSearchRepository {
    func getGithubRepositories(of query: String) -> AnyPublisher<Result<GithubRepositoriesResponse, NetworkError>, Never>
    func getGithubUsers(of query: String) -> AnyPublisher<Result<GithubUsersResponse, NetworkError>, Never>
}

class GithubSearchRepositoryImpl: GithubSearchRepository {
    func getGithubUsers(of query: String) -> AnyPublisher<Result<GithubUsersResponse, NetworkError>, Never> {
        return RestManager.requestObservable(url: Constants.getUsers(of: query))
    }
    
    func getGithubRepositories(of query: String) -> AnyPublisher<Result<GithubRepositoriesResponse, NetworkError>, Never> {
        return RestManager.requestObservable(url: Constants.getRepositories(of: query))
    }
}
