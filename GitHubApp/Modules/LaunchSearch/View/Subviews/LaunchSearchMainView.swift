//
//  LaunchSearchMainView.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 01.03.2021..
//

import UIKit
import SnapKit

class LaunchSearchMainView: UIView {
    
    //MARK: Properties
    let filterButton: SSBadgeButton = {
        let button = SSBadgeButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 100, weight: .light, scale: .medium)
        button.setImage(UIImage(systemName: "slider.horizontal.3", withConfiguration: config), for: .normal)
        button.tintColor = .black
        button.badgeEdgeInsets = UIEdgeInsets(top: 10, left: 35, bottom: 0, right: 0)
        button.badge = "2"
        return button
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "githubLogo")
        return imageView
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.isTranslucent = true
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.isUserInteractionEnabled = false
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UI Setup
private extension LaunchSearchMainView {
    func setupView() {
        setupAppearance()
        addViews()
        setupLayout()
        configureSearchBar()
    }
 
    func setupAppearance() {
        self.backgroundColor = .white
    }
    
    func addViews() {
        addSubviews([filterButton, stackView])
        let views = [logoImageView, searchBar, searchButton]
        stackView.addArrangedSubviews(views)
    }
    
    func setupLayout() {
        filterButton.snp.makeConstraints { (make) in
            make.top.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(30)
            make.width.equalTo(40)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(filterButton.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview().inset(50)
        }
        
        logoImageView.snp.makeConstraints { (make) in
            make.size.equalTo(stackView.snp.width)
        }
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
    }
}

//MARK:  SearchBar Delegate
extension LaunchSearchMainView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 1 {
            searchButton.isUserInteractionEnabled  = true
        } else {
            searchButton.isUserInteractionEnabled = false
        }
    }
}

//MARK: Public methods
extension LaunchSearchMainView {
    func configureBadge(with number: Int) {
        if number != 0 {
            filterButton.badgeLabel.isHidden = false
            filterButton.badgeLabel.text = String(number)
        } else {
            filterButton.badgeLabel.isHidden = true
        }
    }
}
