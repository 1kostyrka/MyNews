//
//  DashboardDashboardViewController.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit

final class DashboardViewController: UIViewController, DashboardViewInput {

    var output: DashboardViewOutput?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        output?.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        showView()
    }
    
    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func showView() {
        let hasSubscriptions = SubscriveService.shared.medias.contains { $0.isSubscribed == true }
        
        emptyView.isHidden = hasSubscriptions
    }

    // MARK: DashboardViewInput

    func setupInitialState() {
    }

}
