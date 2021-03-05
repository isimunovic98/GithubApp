//
//  LaunchSearchViewModel.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 03.03.2021..
//

import Foundation
import Combine

enum SearchOptions {
    case both
    case users
    case repositories
}
class LaunchSearchViewModel {
    var coordinatorDelegate: LaunchSearchCoordinatorDelegate?
    
    var screenData: LaunchSearchModel!
    
    let loadData = CurrentValueSubject<Bool, Never>(true)
    let dataReadyPublisher = PassthroughSubject<Void, Never>()
    
    var saveLastSearchPublisher = PassthroughSubject<String, Never>()
}

//MARK: Bindings
extension LaunchSearchViewModel {
    func initializeScreenData(for subject: CurrentValueSubject<Bool, Never>) -> AnyCancellable {
        return subject
            .map({ [unowned self] _  -> LaunchSearchModel in
                self.createScreenData()
            })
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] screenData in
                self.screenData = screenData
                self.dataReadyPublisher.send()
            })
    }
    
    func attachSearchListener(for subject: PassthroughSubject<String, Never>) -> AnyCancellable {
        return subject
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] searchInput in
                self.saveLastSearch(searchInput)
            })
    }
}

//MARK: Private Methods
private extension LaunchSearchViewModel {
    func createScreenData() -> LaunchSearchModel {
        var count = 0
        
        if Defaults.isRepositoriesSelected() {
            count += 1
        }
        if Defaults.isUsersSelected() {
            count += 1
        }
        
        return LaunchSearchModel(selectedSources: count)
    }
    
    func saveLastSearch(_ searchInput: String) {
        Defaults.saveLastSearch(searchInput)
    }
}

//MARK: Navigation
extension LaunchSearchViewModel {
    func searchGithub() {
        if (Defaults.isRepositoriesSelected() && Defaults.isUsersSelected()) {
            coordinatorDelegate?.presentSearchResult(with: .both)

        } else if Defaults.isRepositoriesSelected() {
            coordinatorDelegate?.presentSearchResult(with: .repositories)

        } else {
            coordinatorDelegate?.presentSearchResult(with: .users)
        }
    }
}
