//
//  GithubRepositoriesCoordinator.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 05.03.2021..
//

import UIKit

protocol SearchResultsCoordinatorDelegate {
    func presentDetails(with detailsModel: DetailsModel)
    func openBrowser(with urlString: String)
    func searchResultDidFinsh()
}

class SearchResultsCoordinator: Coordinator {
    weak var parent: LaunchSearchCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
    }
    
    func start(with searchOption: SearchOptions) {
        var viewControllers = [UIViewController]()
        
        switch searchOption {
        case .both:
            viewControllers.append(searchRepositories())
            viewControllers.append(searchUsers())
        case .repositories:
            viewControllers.append(searchRepositories())
        case .users:
            viewControllers.append(searchUsers())
        }
        let viewModel = TabViewModel()
        viewModel.coordinatorDelegate = self
        let viewController = TabViewController(viewControllers: viewControllers, viewModel: viewModel)
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension SearchResultsCoordinator: SearchResultsCoordinatorDelegate {
    func openBrowser(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
    
    func presentDetails(with detailsModel: DetailsModel) {
        let child = DetailsCoordinator(navigationController: navigationController)
        child.parent = self
        childCoordinators.append(child)
        child.start(with: detailsModel)
    }
    
    func searchResultDidFinsh() {
        parent?.childDidFinish(self)
    }
}

extension SearchResultsCoordinator: ParentCoordinatorDelegate {
    func childDidFinish(_ child: Coordinator) {
        childCoordinators = childCoordinators.filter({$0 !== child})
    }
}


private extension SearchResultsCoordinator {
    func searchRepositories() -> UIViewController {
        let repository = GithubSearchRepositoryImpl()
        let viewModel = RepositoriesViewModel(repository: repository)
        viewModel.coordinatorDelegate = self
        let viewController = RepositoriesViewController(viewModel: viewModel)
        return viewController
    }
    
    func searchUsers() -> UIViewController {
        let repository = GithubSearchRepositoryImpl()
        let viewModel = GithubUsersViewModel(repository: repository)
        viewModel.coordinatorDelegate = self
        let viewController = GithubUsersViewController(viewModel: viewModel)
        return viewController
    }
}
