//
//  SavedCollectionViewCell.swift
//  ios-news
//
//  Created by Ivan Kostyrka on 01.09.2024.
//

import UIKit

protocol SavedCollectionViewCellDelegate: AnyObject {
    func didTapShare(_ cell: SavedCollectionViewCell)
}

class SavedCollectionViewCell: UICollectionViewCell {
    
    
    weak var delegate: SavedCollectionViewCellDelegate?
    
    @IBOutlet weak
    var previewImageView: UIImageView!
    
    @IBOutlet weak
    var titleLabel: UILabel!
    
    @IBOutlet weak
    var descriptionLabel: UILabel!
    
    @IBOutlet weak
    var deleteButton: UIButton!
    
    @IBOutlet weak
    var mediaImageView: UIImageView!
    
    @IBOutlet weak
    var shareButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    @IBAction
    func didTapDeleteButton(_ sender: UIButton) {
    }
    
    @IBAction
    func didTapShareButton(_ sender: UIButton) {
        delegate?.didTapShare(self)
    }
    
    
    func configure() {
        mediaImageView.layer.cornerRadius = mediaImageView.frame.height / 2
    }
    
    func set(newsImage: String, title: String, description: String, mediaImage: String) {
        if let url = URL(string: mediaImage) {
            mediaImageView.kf.setImage(with: url)
        }
        if let url2 = URL(string: newsImage) {
            previewImageView.kf.setImage(with: url2)
        }
        titleLabel.text = title
        descriptionLabel.text = description
    }
}
