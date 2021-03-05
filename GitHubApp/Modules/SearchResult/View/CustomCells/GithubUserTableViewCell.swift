//
//  UserTableViewCell.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 05.03.2021..
//

import UIKit

class GithubUserTableViewCell: UITableViewCell {
    //MARK: Properties
    var openProfile: (() -> Void)?
    var openRepositories: (() -> Void)?
    
    let authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(25)
        return label
    }()
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let openProfileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open Profile", for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(.systemGray2, for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.sizeToFit()
        return button
    }()
    
    let openRepositoriesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open Repositories", for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.setTitleColor(.systemGray2, for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(13)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    override required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension GithubUserTableViewCell {
    func setupView() {
        setupAppearance()
        addViews()
        setupLayout()
        setupButtonActions()
    }
    
    func setupAppearance() {
        contentView.backgroundColor = .white
    }
    
    func addViews() {
        let views = [authorNameLabel, avatarImageView, openProfileButton, openRepositoriesButton]
        contentView.addSubviews(views)
    }
    
    func setupLayout() {
        openProfileButton.snp.makeConstraints { (make) in
            make.leading.bottom.equalToSuperview().inset(10)
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width/4)
        }
        
        openRepositoriesButton.snp.makeConstraints { (make) in
            make.top.bottom.width.equalTo(openProfileButton)
            make.leading.equalTo(openProfileButton.snp.trailing).offset(10)
        }
        
        authorNameLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().inset(UIEdgeInsets(top: 30, left: 10, bottom: 0, right: 0))
        }
        
        avatarImageView.snp.makeConstraints { (make) in
            make.top.trailing.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 20))
            make.size.equalTo(UIScreen.main.bounds.width/3)
        }
    }
    
    func setupButtonActions() {
        openProfileButton.addTarget(self, action: #selector(openProfileButtonTapped), for: .touchUpInside)
        openRepositoriesButton.addTarget(self, action: #selector(openRepositoriesButtonTapped), for: .touchUpInside)
    }
    
    @objc func openProfileButtonTapped() {
        openProfile?()
    }
    
    @objc func openRepositoriesButtonTapped() {
        openRepositories?()
    }
}

extension GithubUserTableViewCell {
    func configure(with screenData: GithubUser) {
        authorNameLabel.text = screenData.login
        avatarImageView.setImageFromUrl(screenData.avatarUrl)
    }
}

