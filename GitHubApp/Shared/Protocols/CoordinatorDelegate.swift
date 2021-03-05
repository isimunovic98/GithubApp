//
//  CoordinatorDelegate.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 05.03.2021..
//

import UIKit

enum NextViewController {
    case launchSearch
    case searchSelection(UIImage)
    case searchResult(SearchOptions)
    case details(DetailsModel)
    case browser(String)
}
protocol CoordinatorDelegate {
    func viewControllerDidFinish(push viewController: NextViewController)
}
