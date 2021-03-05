//
//  UIStackView+Extensions.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 02.03.2021..
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
