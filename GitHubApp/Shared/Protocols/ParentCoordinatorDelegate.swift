//
//  ParentCoordinatorDelegate.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 05.03.2021..
//

import Foundation

protocol ParentCoordinatorDelegate: AnyObject {
    func childDidFinish(_ child: Coordinator)
}
