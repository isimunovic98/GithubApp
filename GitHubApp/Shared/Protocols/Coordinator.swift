//
//  Coordinator.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 02.03.2021..
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}
