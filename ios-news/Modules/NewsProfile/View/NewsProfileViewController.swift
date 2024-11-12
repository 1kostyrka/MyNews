//
//  NewsProfileNewsProfileViewController.swift
//  News
//
//  Created by Ivan Kostyrka on 04/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit
import WebKit

final class NewsProfileViewController: UIViewController, NewsProfileViewInput {
    
    var output: NewsProfileViewOutput?
    
    @IBOutlet weak
    var webView: WKWebView!
    
    let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.style = .large
        loader.color = UIColor(named: "AccentColor")
        return loader
    }()
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        output?.viewIsReady()
    }
    
    func configure() {
        view.addSubview(loader)
        loader.center = view.center
        load()
        if let link = output?.link, !link.isEmpty {
            if let url = URL(string: link) {
                let request = URLRequest(url: url)
                load()
                webView.load(request)
            }
            webView.navigationDelegate = self
        }
    }
    
    func load() {
        loader.startAnimating()
    }
    
    func finishLoad() {
        loader.stopAnimating()
    }
    
    // MARK: NewsProfileViewInput
    
    func setupInitialState() {
    }
    
}

extension NewsProfileViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        finishLoad()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(#function)
    }
}
