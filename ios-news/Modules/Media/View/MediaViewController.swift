//
//  MediaMediaViewController.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit

final class MediaViewController: UIViewController, MediaViewInput {

    var output: MediaViewOutput?

    @IBOutlet weak var tableView: UITableView!
    
    var link: String?
    
    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        output?.viewIsReady()
    }
    
    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    // MARK: MediaViewInput

    func setupInitialState() {
    }

}
