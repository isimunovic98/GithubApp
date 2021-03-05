//
//  GithubUsersViewController.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 05.03.2021..
//

import UIKit
import SnapKit
import Combine

class GithubUsersViewController: UIViewController {
    //MARK: Properties
    var viewModel: GithubUsersViewModel
    var disposables = Set<AnyCancellable>()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGray4
        return tableView
    }()
    
    init(viewModel: GithubUsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        print("users deinit")
    }
}

//MARK: - Lifecycle
extension GithubUsersViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadData.send(true)
    }
}

//MARK: - UI
private extension GithubUsersViewController {
    func setupView() {
        setupAppearance()
        addSubviews()
        setupLayout()
        configureTableView()
    }
    
    func setupAppearance() {
        view.backgroundColor = .systemGray4
    }
    
    func addSubviews() {
        view.addSubview(tableView)
    }
    
    func setupLayout() {
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
}

extension GithubUsersViewController {
    func searchFor(_ input: String) {
        viewModel.searchPublisher.send(input)
    }
}


//MARK: - Methods
private extension GithubUsersViewController {
    func setupBindings() {
        viewModel.initalizeScreenData(for: viewModel.loadData).store(in: &disposables)
        
        viewModel.attachSearchListener(for: viewModel.searchPublisher).store(in: &disposables)
        
        viewModel.dataReadyPublisher
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .store(in: &disposables)

        viewModel.shouldShowBlurView
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] shouldShowBlurView in
                self?.showLoader(shouldShowBlurView)
            })
            .store(in: &disposables)

        viewModel.errorPublisher
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink{ [weak self] errorMessage in
                guard let message = errorMessage else { return }
                self?.presentAlert(with: message)
                self?.showLoader(false)
            }
            .store(in: &disposables)
    }
    
    func showLoader( _ shouldShowLoader: Bool) {
        if shouldShowLoader {
            showLoader()
        } else {
            removeLoader()
        }
    }
    
    func openProfile(of index: Int) {
        viewModel.open(type: .profile, of: index)
    }
    
    func openRepositories(of index: Int) {
        viewModel.open(type: .repositories, of: index)
    }
}

//MARK: - TableViewDelegate
extension GithubUsersViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.screenData.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemGray4
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.screenData[indexPath.section]
        
        let cell: GithubUserTableViewCell = tableView.dequeue(for: indexPath)
        
        cell.openProfile = { [weak self] in
            self?.openProfile(of: indexPath.section)
        }
        
        cell.openRepositories = { [weak self] in
            self?.openRepositories(of: indexPath.section)
        }
        cell.configure(with: data)
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openProfile(of: indexPath.section)
    }
    
    func configureTableView() {
        setTableViewDelegates()
        tableView.register(GithubUserTableViewCell.self, forCellReuseIdentifier: GithubUserTableViewCell.reuseIdentifier)
        tableView.rowHeight = UIScreen.main.bounds.height/3.5
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
