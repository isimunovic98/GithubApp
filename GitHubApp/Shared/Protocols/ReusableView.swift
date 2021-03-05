//
//  ReusableView.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 04.03.2021..
//

import Foundation

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
