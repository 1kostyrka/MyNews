//
//  SavedSavedViewController.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit

final class SavedViewController: UIViewController, SavedViewInput {
    
    var output: SavedViewOutput?
    
    @IBOutlet weak
    var collectionView: UICollectionView!
    
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        output?.viewIsReady()
    }
    
    func configure() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func didTapShare(_ cell: SavedCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        
        let item = output?.news[indexPath.row]
        let text = item?.title ?? ""
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: SavedViewInput
    
    func setupInitialState() {
    }
    
}
