//
//  SingleInformation.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 04.03.2021..
//

import UIKit
import SnapKit

class SingleInformation: UIView {

    let informationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemGray
        return imageView
    }()

    let informationTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = label.font.withSize(14)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let dividorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.textAlignment = .center
        label.font = label.font.withSize(12)
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
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

private extension SingleInformation {
    func setupView() {
        setupAppearance()
        addViews()
        setupLayout()
    }
    
    func setupAppearance() {
        backgroundColor = .darkGray
        self.layer.cornerRadius = 5
    }
    
    func addViews() {
        let views = [informationIcon, informationTitleLabel, dividorLine, numberLabel]
        stackView.addArrangedSubviews(views)
        addSubview(stackView)
    }
    
    func setupLayout() {
        informationIcon.snp.makeConstraints { (make) in
            make.size.equalTo(20)
        }
        dividorLine.snp.makeConstraints { (make) in
            make.width.equalTo(1)
        }
        
        numberLabel.snp.makeConstraints { (make) in
            make.width.equalTo(30)
        }
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
