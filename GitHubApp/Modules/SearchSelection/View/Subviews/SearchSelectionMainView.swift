//
//  SearchSelectionMainView.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 03.03.2021..
//

import UIKit
import SnapKit

class SearchSelectionMainView: UIView {
    //MARK: Properties
    var applyTapped: (() -> Void)?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Look for"
        label.font = label.font.withSize(25)
        return label
    }()
    
    let horizontalDividor: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    let repositorySelection: SingleSelection = {
        let selectionView = SingleSelection()
        selectionView.translatesAutoresizingMaskIntoConstraints = false
        selectionView.selectionTitle.text = "Repositories"
        return selectionView
    }()
    
    let usersSelection: SingleSelection = {
        let selectionView = SingleSelection()
        selectionView.translatesAutoresizingMaskIntoConstraints = false
        selectionView.selectionTitle.text = "Users"
        return selectionView
    }()
    
    let selectionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let applyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Apply", for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor(white: 1, alpha: 0.3), for: .disabled)
        button.setTitleColor(UIColor(white: 1, alpha: 1), for: .normal)
        return button
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topLeft, .topRight], radius: 15)
    }
}

private extension SearchSelectionMainView {
    func setupView() {
        setupAppearance()
        addViews()
        setupLayout()
        setupActions()
    }
    
    func setupAppearance() {
        backgroundColor = .white
    }
    
    func addViews() {
        selectionStackView.addArrangedSubviews([repositorySelection, usersSelection])
        let views = [titleLabel, horizontalDividor, selectionStackView, applyButton]
        addSubviews(views)
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview()
        }
        
        horizontalDividor.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        applyButton.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 50, bottom: 20, right: 50))
            make.height.equalTo(40)
        }
        
        selectionStackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(100)
        }
    }
}

//MARK: Actions
extension SearchSelectionMainView {
    func setupActions() {
        applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
    }
    
    @objc func applyButtonTapped() {
        applyTapped?()
    }
}

//MARK: Public Methods
extension SearchSelectionMainView {
    func configure(with screenData: SearchSelection) {
        repositorySelection.checkBox.on = screenData.repositoriesIsSelected
        usersSelection.checkBox.on = screenData.usersIsSelected
        applyButton.isUserInteractionEnabled = screenData.applyEnabled
    }
}
