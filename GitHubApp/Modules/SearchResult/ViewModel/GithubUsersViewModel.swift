//
//  GithubUsersViewModel.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 05.03.2021..
//

import Foundation
import Combine

enum ButtonNavigation {
    case profile
    case repositories
}

class GithubUsersViewModel {
    var coordinatorDelegate: SearchResultsCoordinatorDelegate?
    
    var screenData: [GithubUser] = []
    
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

extension GithubUsersViewModel {
    func initalizeScreenData(for subject: CurrentValueSubject<Bool, Never>) -> AnyCancellable {
        return subject
            .flatMap({ [unowned self] (value) -> AnyPublisher<Result<GithubUsersResponse, NetworkError>, Never> in
                self.shouldShowBlurView.send(value)
                return repository.getGithubUsers(of: Defaults.getLastSearch())
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
            .flatMap({ [unowned self] (input) -> AnyPublisher<Result<GithubUsersResponse, NetworkError>, Never> in
                self.shouldShowBlurView.send(true)
                return repository.getGithubUsers(of: input)
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
}


extension GithubUsersViewModel {
    func open(type: ButtonNavigation, of index: Int) {
        switch type {
        case .profile:
            let detailsModel = DetailsModel(screenData[index])
            coordinatorDelegate?.presentDetails(with: detailsModel)
        case .repositories:
            let urlString = Constants.allRepositories(of: screenData[index].login)
            coordinatorDelegate?.openBrowser(with: urlString)
        }
    }
}
