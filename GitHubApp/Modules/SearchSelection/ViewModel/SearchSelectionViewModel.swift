//
//  SearchSelectionViewModel.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 03.03.2021..
//

import Foundation
import Combine

enum SelectedSource {
    case repositories
    case users
}

class SearchSelectionViewModel {
    //MARK: Properties
    var coordinatorDelegate: LaunchSearchCoordinatorDelegate?
    
    var screenData: SearchSelection!
    
    let selectionPublisher = PassthroughSubject<SelectedSource, Never>()
    let applyTappedPublisher = PassthroughSubject<Void, Never>()
    
    let loadData = CurrentValueSubject<Bool, Never>(true)
    let dataReadyPublisher = PassthroughSubject<Void, Never>()
    
    deinit {
        print("Search Selection VM deinit")
    }
}

extension SearchSelectionViewModel {
    func initializeScreenData(for subject: CurrentValueSubject<Bool, Never>) -> AnyCancellable {
        return subject
            .map({ [unowned self] _  -> SearchSelection in
                self.createScreenData()
            })
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] screenData in
                self.screenData = screenData
                self.dataReadyPublisher.send()
            })
    }
    
    func attachSelectionListener(for subject: PassthroughSubject<SelectedSource, Never>) -> AnyCancellable {
        return subject
            .map({ [unowned self] selection  -> SearchSelection in
                return self.updateSelection(for: selection, in: self.screenData)
            })
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] screenData in
                self.screenData = screenData
                self.dataReadyPublisher.send()
            })
        
    }
    
    func attachApplyButtonListener(for subject: PassthroughSubject<Void, Never>) -> AnyCancellable {
        return subject
            .map({ [unowned self] in
                self.saveSelections()
            })
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: {
            })
    }
}

private extension SearchSelectionViewModel {
    func createScreenData() -> SearchSelection {
        let repositorySelected = Defaults.isRepositoriesSelected()
        let usersSelected = Defaults.isUsersSelected()
        var applyEnabled = false
        
        if (repositorySelected || usersSelected) {
            applyEnabled = true
        }
        return SearchSelection(repositoriesIsSelected: repositorySelected, usersIsSelected: usersSelected, applyEnabled: applyEnabled)
    }
    
    func updateSelection(for source: SelectedSource, in screenData: SearchSelection) -> SearchSelection {
        var tempData = screenData
        switch source {
        case .repositories:
            let updatedValue = !tempData.repositoriesIsSelected
            tempData.repositoriesIsSelected = updatedValue
        case .users:
            let updatedValue = !tempData.usersIsSelected
            tempData.usersIsSelected = updatedValue
        }
        
        var applyEnabled = false
        
        if (tempData.repositoriesIsSelected || tempData.usersIsSelected) {
            applyEnabled = true
        }

        tempData.applyEnabled = applyEnabled
        
        return tempData
    }
    
    func saveSelections() {
        let repositorySelected = screenData.repositoriesIsSelected
        let usersSelected = screenData.usersIsSelected
        Defaults.saveRepositorySelection(repositorySelected)
        Defaults.saveUsersSelection(usersSelected)
    }
}
