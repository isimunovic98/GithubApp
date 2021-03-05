//
//  DetailsCoordinator.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 05.03.2021..
//

import UIKit
protocol DetailsCoordinatorDelegate {
    func detailsDidFinish()
}

class DetailsCoordinator: Coordinator {
    weak var parent: SearchResultsCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    func start(with detailsModel: DetailsModel) {
        let viewModel = DetailsViewModel(screenData: detailsModel)
        viewModel.coordinatorDelegate = self
        let viewController = DetailsViewController(viewModel: viewModel)
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(viewController, animated: false)
    }
    
}

extension DetailsCoordinator: DetailsCoordinatorDelegate {
    func detailsDidFinish() {
        navigationController.popViewController(animated: false)
        parent?.childDidFinish(self)
    }
}

//extension DetailsCoordinator: CoordinatorDelegate {
//    func viewControllerDidFinish(push viewController: NextViewController) {
//        navigationController.popViewController(animated: false)
//        parent?.childDidFinish(self, present: viewController)
//    }
//}
