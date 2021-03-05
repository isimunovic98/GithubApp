//
//  RepositoryTableViewCell.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 04.03.2021..
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    //MARK: Properties
    var openAuthorDetails: (() -> Void)?
    var openBrowser: (() -> Void)?
    
    let repositoryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    let authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(12)
        label.numberOfLines = 1
        label.textColor = .systemGray2
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        label.numberOfLines = 4
        label.textColor = .systemGray2
        return label
    }()
    
    let repositoryInformationView: RepositoryInformations = {
        let view = RepositoryInformations()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let grayedBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray2
        return view
    }()
    
    let dividorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.2
        return view
    }()
    
    let authorDetailsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Author Details", for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let openBrowserButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open in browser", for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .white
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

//MARK: - UI
private extension RepositoryTableViewCell {
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
        repositoryInformationView.addSubview(dividorLine)
        grayedBackgroundView.addSubview(repositoryInformationView)
        let views = [repositoryNameLabel, authorNameLabel, descriptionLabel, authorDetailsButton, openBrowserButton, grayedBackgroundView]
        addSubviews(views)
        addSubview(dividorLine)
    }
    
    func setupLayout() {
        repositoryNameLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(grayedBackgroundView.snp.leading).offset(-10)
            make.height.equalTo(20)
        }
        
        authorNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(repositoryNameLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(repositoryNameLabel)
            make.height.equalTo(20)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(authorNameLabel.snp.bottom).inset(10)
            make.bottom.equalTo(dividorLine).offset(-10)
            make.leading.trailing.equalTo(repositoryNameLabel)
        }
        
        authorDetailsButton.snp.makeConstraints { (make) in
            make.leading.bottom.equalToSuperview().inset(10)
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width/4)
        }
        
        openBrowserButton.snp.makeConstraints { (make) in
            make.top.bottom.width.equalTo(authorDetailsButton)
            make.leading.equalTo(authorDetailsButton.snp.trailing).offset(10)
        }
        
        dividorLine.snp.makeConstraints { (make) in
            make.bottom.equalTo(authorDetailsButton.snp.top).offset(-10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        grayedBackgroundView.snp.makeConstraints { (make) in
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width/3)
        }

        repositoryInformationView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(grayedBackgroundView).inset(5)
            make.bottom.equalTo(dividorLine).inset(5)
        }
    }
    
    func setupButtonActions() {
        authorDetailsButton.addTarget(self, action: #selector(authorDetailsButtonTapped), for: .touchUpInside)
        openBrowserButton.addTarget(self, action: #selector(openBrowserButtonTapped), for: .touchUpInside)
    }
    
    @objc func authorDetailsButtonTapped() {
        openAuthorDetails?()
    }
    
    @objc func openBrowserButtonTapped() {
        openBrowser?()
    }
}

extension RepositoryTableViewCell {
    func configure(with screenData: RepositoryResponseSingle) {
        repositoryNameLabel.text = screenData.name
        authorNameLabel.text = screenData.owner.ownerName
        descriptionLabel.text = screenData.description ?? ""
        repositoryInformationView.configure(with: screenData)
    }
}
