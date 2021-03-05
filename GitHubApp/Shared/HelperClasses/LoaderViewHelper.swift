//
//  LoaderHelper.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 05.03.2021..
//

import UIKit

class LoaderViewHelper {
    static let blurView: LoaderView = {
        let view = LoaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    static func addLoader(to view: UIView) {
        view.addSubview(blurView)
        blurView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    static func removeLoader() {
        blurView.removeFromSuperview()
    }
}
