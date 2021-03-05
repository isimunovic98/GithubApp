//
//  DetailsViewModel.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 05.03.2021..
//

import Foundation

class DetailsViewModel {
    var coordinatorDelegate: DetailsCoordinatorDelegate?
    
    var screenData: DetailsModel

    init(screenData: DetailsModel) {
        self.screenData = screenData
    }
    
    func backButtonTapped() {
        coordinatorDelegate?.detailsDidFinish()
    }
}
