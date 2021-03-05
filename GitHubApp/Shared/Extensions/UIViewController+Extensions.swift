//
//  UIViewController+Extensions.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 05.03.2021..
//

import UIKit

extension UIViewController {
    func showLoader() {
        LoaderViewHelper.addLoader(to: self.view)
    }
    
    func removeLoader() {
        LoaderViewHelper.removeLoader()
    }
    
    func presentAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: false, completion: nil)
    }
}
