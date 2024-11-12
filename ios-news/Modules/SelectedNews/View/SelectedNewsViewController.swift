//
//  SelectedNewsSelectedNewsViewController.swift
//  News
//
//  Created by Ivan Kostyrka on 16/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit

final class SelectedNewsViewController: UIViewController, SelectedNewsViewInput {
    
    var output: SelectedNewsViewOutput?
    
    @IBOutlet
    weak var saveButton: UIButton!
    
    var selectedNews: NewsStorage?
    
    @IBOutlet
    weak var imageView: UIImageView!
    
    @IBOutlet
    weak var titleLabel: UILabel!
    
    @IBOutlet
    weak var descriptionLabel: UILabel!
    
    
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        output?.viewIsReady()
    }
    
    @IBAction
    func didTapSaveButton(_ sender: UIButton) {
        guard let news = selectedNews else { return }
        
        if output?.isNewsSaved(news) == true {
            output?.removeSavedNews(news)
            sender.setTitle("Зберегти", for: .normal)
        } else {
            output?.saveNews(news)
            sender.setTitle("Видалити", for: .normal)
        }
    }
    
    func configure() {
        saveButton.layer.cornerRadius = 10
        
        if let news = selectedNews {
            titleLabel.text = news.title
            descriptionLabel.text = news.description
            
            if let image = news.image, let url = URL(string: image) {
                imageView.kf.setImage(with: url)
            }
        }
        
    }
    
    // MARK: SelectedNewsViewInput
    
    func setupInitialState() {
    }
    
}
