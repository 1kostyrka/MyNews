//
//  DashboardTableViewCell.swift
//  ios-news
//
//  Created by Ivan Kostyrka on 05.09.2024.
//

import UIKit
import Kingfisher

class DashboardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var previewImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel! 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    func configure() {
        previewImageView.layer.cornerRadius = 10
    }
    
    func set(image: String, title: String, description: String, localImage: Data? = nil) {
        if let url = URL(string: image) {
            previewImageView.kf.setImage(with: url)
        } else {
            if let localImage = localImage {
                previewImageView.image = UIImage(data: localImage)
            }
        }
        titleLabel.text = title
        descriptionLabel.text = description
    }
}
