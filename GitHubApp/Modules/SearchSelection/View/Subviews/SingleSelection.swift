//
//  SingleSelection.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 03.03.2021..
//

import UIKit
import BEMCheckBox

class SingleSelection: UIView {
    //MARK: Properties
    var checkBoxTapped: (() -> Void)?
    
    let checkBox: BEMCheckBox = {
        let checbox = BEMCheckBox()
        checbox.translatesAutoresizingMaskIntoConstraints = false
        checbox.boxType = .square
        checbox.tintColor = .darkGray
        checbox.onCheckColor = .white
        checbox.onTintColor = .systemGreen
        checbox.onFillColor = .systemGreen
        checbox.animationDuration = 0
        return checbox
    }()
    
    let selectionTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        checkBox.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SingleSelection {
    func setupView() {
        addViews()
        setupLayout()
    }
    
    func addViews() {
        let views = [checkBox, selectionTitle]
        stackView.addArrangedSubviews(views)
        addSubview(stackView)
    }
    
    func setupLayout() {
        checkBox.snp.makeConstraints { (make) in
            make.size.equalTo(20)
        }
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

extension SingleSelection: BEMCheckBoxDelegate {
    func didTap(_ checkBox: BEMCheckBox) {
        checkBoxTapped?()
    }
}
