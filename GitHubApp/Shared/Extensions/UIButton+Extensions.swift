//
//  UIButton+Extensions.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 03.03.2021..
//

import UIKit

extension UIButton {
    override open var isUserInteractionEnabled: Bool {
        didSet {
            DispatchQueue.main.async {
                if self.isUserInteractionEnabled {
                    self.backgroundColor = .darkGray
                }
                else {
                    self.backgroundColor = .lightGray
                }
            }
        }
    }
}
