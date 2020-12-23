//
//  AuthWebViewController.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 20.12.2020.
//

import UIKit
import WebKit
import SnapKit

class AuthWebViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }()
    
    // MARK: - Private
    
    private let requestService: IRequestService
    
    // MARK: - Init
    
    init(requestService: IRequestService) {
        self.requestService = requestService
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        if let request = requestService.authCodeRequest.urlRequest {
            webView.load(request)
        }
    }
    
    // MARK: - Helpful
    
    private func setupNavBar() {
        let closeBarButton = UIBarButtonItem(title: "Close",
                                             style: .done,
                                             target: self,
                                             action: #selector(actionClose))
        let refreshBarButton = UIBarButtonItem(barButtonSystemItem: .refresh,
                                               target: self,
                                               action: #selector(actionRefresh))
        navigationItem.rightBarButtonItem = closeBarButton
        navigationItem.leftBarButtonItem = refreshBarButton
    }
    
    // MARK: - Actions
    
    @objc
    private func actionClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func actionRefresh() {
        webView.reload()
    }

}

extension AuthWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        requestService.requestForCallback(with: navigationAction.request)
        decisionHandler(.allow)
    }
}
