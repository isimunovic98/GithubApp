//
//  LaunchSearchCoordinator.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 04.03.2021..
//

import UIKit
protocol LaunchSearchCoordinatorDelegate {
    func presentSearchSelection(with backgroundImage: UIImage)
    func dismissSearchSelection()
    func presentSearchResult(with searchOption: SearchOptions)
}

class LaunchSearchCoordinator: Coordinator {
    weak var parent: AppCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = LaunchSearchViewModel()
        viewModel.coordinatorDelegate = self
        let viewController = LaunchSearchViewController(viewModel: viewModel)
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: false)
    }
    
}

extension LaunchSearchCoordinator: LaunchSearchCoordinatorDelegate {
    func presentSearchSelection(with backgroundImage: UIImage) {
        let viewModel = SearchSelectionViewModel()
        viewModel.coordinatorDelegate = self
        let viewController = SearchSelectionViewController(viewModel: viewModel)
        viewController.backgroundImage = backgroundImage
        viewController.modalPresentationStyle = .fullScreen
        navigationController.present(viewController, animated: false, completion: nil)
    }
    
    func dismissSearchSelection(){
        navigationController.dismiss(animated: false, completion: nil)
    }
    
    func presentSearchResult(with searchOption: SearchOptions) {
        let child = SearchResultsCoordinator(navigationController: navigationController)
        child.parent = self
        childCoordinators.append(child)
        child.start(with: searchOption)
    }
}

extension LaunchSearchCoordinator: ParentCoordinatorDelegate {
    func childDidFinish(_ child: Coordinator) {
        childCoordinators = childCoordinators.filter({$0 !== child})
    }
}
