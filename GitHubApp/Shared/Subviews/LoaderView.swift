//
//  BlurEffectView.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 03.03.2021..
//

import UIKit
class LoaderView: UIView {

    let blurEffectView: UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false

        return visualEffectView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LoaderView {
    func setupView() {
        addSubview(blurEffectView)
        setupConstraints()
        addLoader()
    }
    
    func setupConstraints() {
        blurEffectView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    func addLoader() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center
        activityIndicator.startAnimating()
    }
}
