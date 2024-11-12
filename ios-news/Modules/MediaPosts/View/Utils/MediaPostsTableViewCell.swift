//
//  MediaPostsTableViewCell.swift
//  ios-news
//
//  Created by Ivan Kostyrka on 04.09.2024.
//

import UIKit
import Kingfisher

class MediaPostsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configure() {
        
    }
    
    func set(image: String, title: String) {
        if let url = URL(string: image) {
            previewImageView.kf.setImage(with: url)
        }
        titleLabel.text = title
    }
    
}
