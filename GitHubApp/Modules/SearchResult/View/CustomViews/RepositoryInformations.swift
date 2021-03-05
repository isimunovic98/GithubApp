//
//  RepositoryInformations.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 04.03.2021..
//

import UIKit

class RepositoryInformations: UIView {

    let securityIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "lock")
        imageView.tintColor = .systemGray
        return imageView
    }()

    let watchersView: SingleInformation = {
        let view = SingleInformation()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.informationIcon.image = UIImage(systemName: "eye")
        view.informationTitleLabel.text = "Watch"
        return view
    }()
    
    let starView: SingleInformation = {
        let view = SingleInformation()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.informationIcon.image = UIImage(systemName: "star")
        view.informationTitleLabel.text = "Star"
        return view
    }()
    
    let forkView: SingleInformation = {
        let view = SingleInformation()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.informationIcon.image = UIImage(systemName: "tuningfork")
        view.informationTitleLabel.text = "Fork"
        return view
    }()
    
    let issuesView: SingleInformation = {
        let view = SingleInformation()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.informationIcon.image = UIImage(systemName: "exclamationmark.circle")
        view.informationTitleLabel.text = "Issues"
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RepositoryInformations {
    func setupView() {
        setupAppearance()
        addViews()
        setupLayout()
    }
    
    func setupAppearance() {
        backgroundColor = .clear
    }
    
    func addViews() {
        let views = [watchersView, starView, forkView, issuesView]
        stackView.addArrangedSubviews(views)
        addSubviews([securityIcon, stackView])
    }
    
    func setupLayout() {
        securityIcon.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview()
        }
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(securityIcon.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
}

extension RepositoryInformations {
    func configure(with screenData: RepositoryResponseSingle) {
        if screenData.isPrivate {
            securityIcon.image = UIImage(systemName: "lock")
        } else {
            securityIcon.image = UIImage(systemName: "lock.open")
        }
        watchersView.numberLabel.text = String(screenData.watchersCount)
        starView.numberLabel.text = String(screenData.stargazersCount)
        forkView.numberLabel.text = String(screenData.forksCount)
        issuesView.numberLabel.text = String(screenData.openIssuesCount)
    }
}
