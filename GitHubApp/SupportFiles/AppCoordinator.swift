//
//  AppCoordinator.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 04.03.2021..
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        presentLaunchSearch()
    }
}

extension AppCoordinator {
    func presentLaunchSearch() {
        let child = LaunchSearchCoordinator(navigationController: navigationController)
        child.parent = self
        childCoordinators.append(child)
        child.start()
    }
}
