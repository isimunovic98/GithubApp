//
//  ViewController.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 01.03.2021..
//

import UIKit
import SnapKit
import Combine

class LaunchSearchViewController: UIViewController {
    //MARK: Properties    
    var viewModel: LaunchSearchViewModel
    
    var disposables = Set<AnyCancellable>()
    
    let launchSearchView: LaunchSearchMainView = {
        let view = LaunchSearchMainView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: LaunchSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Lifecycle
extension LaunchSearchViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        viewModel.loadData.send(true)
    }

}

private extension LaunchSearchViewController {
    func setupView() {
        addViews()
        setupLayout()
        setupActions()
    }
    
    func addViews() {
        let views = [launchSearchView]
        view.addSubviews(views)
    }

    func setupLayout() {
        launchSearchView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - Bindings
private extension LaunchSearchViewController {
    func setupBindings() {
        viewModel.initializeScreenData(for: viewModel.loadData).store(in: &disposables)
        
        viewModel.attachSearchListener(for: viewModel.saveLastSearchPublisher).store(in: &disposables)
        
        viewModel.dataReadyPublisher
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.reloadData()
            })
            .store(in: &disposables)
    }
    
    func reloadData() {
        launchSearchView.configureBadge(with: viewModel.screenData.selectedSources)
    }
}

//MARK: - Actions
extension LaunchSearchViewController {
    func setupActions() {
        launchSearchView.filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        launchSearchView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    @objc func filterButtonTapped() {
        let backgroundImage = self.view.asImage()
        viewModel.coordinatorDelegate?.presentSearchSelection(with: backgroundImage)
    }
    
    @objc func searchButtonTapped() {
        guard let searchInput = launchSearchView.searchBar.text else {
            return
        }
        viewModel.saveLastSearchPublisher.send(searchInput)
        viewModel.searchGithub()
    }
}
