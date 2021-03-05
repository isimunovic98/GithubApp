//
//  DetailsViewController.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 05.03.2021..
//

import UIKit
import SnapKit
import WebKit

class DetailsViewController: UIViewController {
    //MARK: Properties
    var viewModel: DetailsViewModel
    
    let webView: WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupWebView()
        loadWebPage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
    }
}

private extension DetailsViewController {
    func setupView() {
        view.addSubview(webView)
        setupLayout()
    }
    
    func setupLayout() {
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupNavigationBar() {
        let backButton: UIBarButtonItem = {
            let buttonImage = UIImage(systemName: "arrow.left")
            let button = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: #selector(backTapped))
            button.tintColor = .black
            return button
        }()
        navigationItem.setLeftBarButton(backButton, animated: true)
        navigationItem.title = viewModel.screenData.title
    }
    
    @objc func backTapped() { viewModel.backButtonTapped() }
}

extension DetailsViewController: WKNavigationDelegate {
    func setupWebView() {
        webView.navigationDelegate = self
    }
    
    func loadWebPage() {
        guard let url = viewModel.screenData.webUrl else {return}
        let urlRequest = URLRequest(url: url)
        
        webView.load(urlRequest)
        webView.allowsBackForwardNavigationGestures = true
    }
}
