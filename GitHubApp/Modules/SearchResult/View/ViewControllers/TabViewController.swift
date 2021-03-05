//
//  TabViewController.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 05.03.2021..
//

import UIKit
import Tabman
import Pageboy
import Combine

class TabViewController: TabmanViewController {
    //MARK: Properties
    private var viewControllers: [UIViewController]
    var viewModel: TabViewModel
    
    //Publishers
    let textDidChangePublisher = PassthroughSubject<String, Never>()
    var disposables = Set<AnyCancellable>()
    
    let bar = TMBar.ButtonBar()
    
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    init(viewControllers: [UIViewController], viewModel: TabViewModel) {
        self.viewControllers = viewControllers
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        print("tab deinit")
    }
    
}

//MARK: Lifecycle
extension TabViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.searchResultDidFinish()
    }
}

private extension TabViewController {
    func setupView() {
        setupBar()
        setupSearchBar()
        setupBarAppearance()
    }
    
    func setupBar() {
        self.dataSource = self
    
        bar.layout.transitionStyle = .progressive
        addBar(bar, dataSource: self, at: .top)
        bar.layout.contentMode = .fit
        bar.isHidden = false
        if viewControllers.count < 2 {
            bar.isHidden = true
            searchBar.placeholder = viewModel.lastSearch
        }
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
     
    func setupBarAppearance() {
        bar.scrollMode = .interactive
        bar.buttons.customize { (button) in
            button.tintColor = .systemGray2
            button.selectedTintColor = .systemGray2
        }
        bar.indicator.tintColor = .darkGray
    }
    
    func setupBindings() {
        textDidChangePublisher
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] input in
                self?.searchFor(input)
            })
            .store(in: &disposables)
    }

    func searchFor(_ input: String) {
        if let repositoriesViewController = viewControllers[currentIndex!] as? RepositoriesViewController {
            repositoriesViewController.searchFor(input)
        }
        if let usersViewController = viewControllers[currentIndex!] as? GithubUsersViewController {
            usersViewController.searchFor(input)
        }
    }
}

extension TabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        if viewControllers[index] is RepositoriesViewController {
            return TMBarItem(title: "Repositories")
        } else {
            return TMBarItem(title: "Users")
        }
    }
}

//MARK: SearchBar
extension TabViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let input = searchBar.text else {
            return
        }
        if input.count > 1 {
            textDidChangePublisher.send(input)
        }
    }
}
