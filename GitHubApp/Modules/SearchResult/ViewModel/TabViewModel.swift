//
//  TabViewViewModel.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 05.03.2021..
//

import Foundation

class TabViewModel {
    var coordinatorDelegate: SearchResultsCoordinatorDelegate?
    var lastSearch = Defaults.getLastSearch()
    
    func searchResultDidFinish() {
        coordinatorDelegate?.searchResultDidFinsh()
    }
}
