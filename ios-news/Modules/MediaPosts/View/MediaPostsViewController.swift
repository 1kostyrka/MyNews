//
//  MediaPostsMediaPostsViewController.swift
//  News
//
//  Created by Ivan Kostyrka on 04/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit

final class MediaPostsViewController: UIViewController, MediaPostsViewInput {
    
    var output: MediaPostsViewOutput?
    
    @IBOutlet weak
    var tableView: UITableView!
    
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        output?.viewIsReady()
        
    }
    
    func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    @objc private func refreshData(_ sender: UIRefreshControl) {
        
        sender.endRefreshing()
        reload()
    }
    
    
    
    // MARK: MediaPostsViewInput
    
    func setupInitialState() {
    }
    
}
