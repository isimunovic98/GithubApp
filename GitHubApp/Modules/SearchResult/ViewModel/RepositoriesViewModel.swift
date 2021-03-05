//
//  RepositoriesViewModel.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 04.03.2021..
//

import Foundation
import Combine

class RepositoriesViewModel {
    var coordinatorDelegate: SearchResultsCoordinatorDelegate?
    
    var screenData: [RepositoryResponseSingle] = []
    
    var repository: GithubSearchRepository
    
    let loadData = CurrentValueSubject<Bool, Never>(true)
    var dataReadyPublisher = PassthroughSubject<Void, Never>()
    var errorPublisher = PassthroughSubject<String?, Never>()
    var shouldShowBlurView = PassthroughSubject<Bool, Never>()
    var searchPublisher = PassthroughSubject<String, Never>()
    
    init(repository: GithubSearchRepository) {
        self.repository = repository
    }
}

extension RepositoriesViewModel {
    func initalizeScreenData(for subject: CurrentValueSubject<Bool, Never>) -> AnyCancellable {
        return subject
            .flatMap({ [unowned self] (value) -> AnyPublisher<Result<GithubRepositoriesResponse, NetworkError>, Never> in
                self.shouldShowBlurView.send(value)
                return repository.getGithubRepositories(of: Defaults.getLastSearch())
            })
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] result in
                switch result {
                case .success(let data):
                    self.screenData = data.items
                    self.dataReadyPublisher.send()
                    self.shouldShowBlurView.send(false)
                case .failure(let error):
                    self.errorPublisher.send(error.localizedDescription)
                }
            })
    }
    func attachSearchListener(for subject: PassthroughSubject<String, Never>) -> AnyCancellable {
        return subject
            .flatMap({ [unowned self] (input) -> AnyPublisher<Result<GithubRepositoriesResponse, NetworkError>, Never> in
                self.shouldShowBlurView.send(true)
                return repository.getGithubRepositories(of: input)
            })
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] result in
                switch result {
                case .success(let data):
                    self.screenData = data.items
                    self.dataReadyPublisher.send()
                    self.shouldShowBlurView.send(false)
                case .failure(let error):
                    self.errorPublisher.send(error.localizedDescription)
                }
            })
    }
    
    func openAuthorDetails(of index: Int) {
        coordinatorDelegate?.presentDetails(with: DetailsModel(screenData[index], type: .author))
    }
    
    func openRepositoryDetails(of index: Int) {
        coordinatorDelegate?.presentDetails(with: DetailsModel(screenData[index], type: .repository))
    }
    
    func openBrowser(of index: Int) {
        let urlString = Constants.repositoryUrl(screenData[index].fullName)
        coordinatorDelegate?.openBrowser(with: urlString)
    }
}
