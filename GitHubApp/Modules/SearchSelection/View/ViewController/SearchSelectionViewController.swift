//
//  SearchSelectionViewController.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 03.03.2021..
//

import UIKit
import Combine

class SearchSelectionViewController: UIViewController {
    //MARK: Properites
    var backgroundImage: UIImage? {
        didSet {
            backgroundImageView.image = backgroundImage
        }
    }
    
    let viewModel: SearchSelectionViewModel
    
    var disposables = Set<AnyCancellable>()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let dimmerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let searchSelectionView: SearchSelectionMainView = {
        let view = SearchSelectionMainView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: Init
    init(viewModel: SearchSelectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("SearchSelection VC deinit")
    }
    
}

//MARK: - Lifecycle
extension SearchSelectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
    }
}

//MARK: - UI Setup
private extension SearchSelectionViewController {
    func setupView() {
        setGestures()
        setupAppearance()
        addViews()
        setupLayout()
    }
    
    func setGestures() {
        let blurTap = UITapGestureRecognizer(target: self, action: #selector(blurEffectViewTapped))
        dimmerView.addGestureRecognizer(blurTap)
        dimmerView.isUserInteractionEnabled = true
    }

    func setupAppearance() {
        dimmerView.alpha = 0.7
        dimmerView.backgroundColor = .black
    }
    
    func addViews() {
        let views = [backgroundImageView, dimmerView, searchSelectionView]
        view.addSubviews(views)
    }
    
    func setupLayout() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        dimmerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    
        searchSelectionView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height/2.5)
        }
        
    }
}

//MARK: - Bindings
private extension SearchSelectionViewController {
    func setupBindings() {
        viewModel.initializeScreenData(for: viewModel.loadData).store(in: &disposables)
        
        viewModel.dataReadyPublisher
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.reloadData()
            })
            .store(in: &disposables)
        
        viewModel.attachApplyButtonListener(for: viewModel.applyTappedPublisher).store(in: &disposables)
        
        viewModel.attachSelectionListener(for: viewModel.selectionPublisher).store(in: &disposables)
        
        //Checkbox taped
        searchSelectionView.repositorySelection.checkBoxTapped = { [weak self]  in
            self?.viewModel.selectionPublisher.send(.repositories)
        }
        
        searchSelectionView.usersSelection.checkBoxTapped = { [weak self]  in
            self?.viewModel.selectionPublisher.send(.users)
        }
        
        //Apply tapped
        searchSelectionView.applyTapped = { [weak self] in
            self?.viewModel.applyTappedPublisher.send()
            self?.viewModel.coordinatorDelegate?.dismissSearchSelection()
        }
    }
    
    func reloadData() {
        searchSelectionView.configure(with: viewModel.screenData)
    }
}

//MARK: Bottom Card
private extension SearchSelectionViewController {
    @objc func blurEffectViewTapped() {
            
        let hideCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn, animations: {
            self.view.layoutIfNeeded()
        })
        
        hideCard.addAnimations {
            self.dimmerView.alpha = 0
        }
        
        hideCard.addCompletion { (position) in
            if position == .end {
                if(self.presentingViewController != nil) {
                    self.dismiss(animated: false, completion: nil)
                }
            }
        }
        
        hideCard.startAnimation()
    }
}
