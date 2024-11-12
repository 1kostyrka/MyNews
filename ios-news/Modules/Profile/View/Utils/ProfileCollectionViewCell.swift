//
//  ProfileCollectionViewCell.swift
//  ios-news
//
//  Created by Ivan Kostyrka on 03.09.2024.
//

import UIKit
import Kingfisher

class ProfileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak
    var previewImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    func configure() {
        
    }
    
    func set(image: String) {
        if let url = URL(string: image) {
            previewImageView.kf.setImage(with: url)
        }
    }
}
