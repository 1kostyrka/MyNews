//
//  MediaTableViewCell.swift
//  ios-news
//
//  Created by Ivan Kostyrka on 31.08.2024.
//

import UIKit
import Kingfisher

class MediaTableViewCell: UITableViewCell {
    
    @IBOutlet var mediaImageView: UIImageView!
    @IBOutlet var mediaLabel: UILabel!
    
    override func awakeFromNib() {
        super .awakeFromNib()
        configure()
    }
    
    func configure() {
        
    }
    
    func set(image: String, text: String) {
        if let url = URL(string: image) {
            mediaImageView.kf.setImage(with: url)
            
        }
        mediaLabel.text = text
    }
    
}

