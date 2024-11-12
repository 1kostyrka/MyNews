//
//  ProfileProfileViewController.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController, ProfileViewInput {

    var output: ProfileViewOutput?

    @IBOutlet weak
    var collectionView: UICollectionView!
    
    @IBOutlet weak
    var profileImageView: UIImageView!
    
    @IBOutlet weak
    var nameLabel: UILabel!
    
    @IBOutlet weak
    var biographyLabel: UILabel!
    
    @IBOutlet weak
    var newsValueLabel: UILabel!
    
    @IBOutlet weak
    var followersValueLabel: UILabel!
    
    @IBOutlet weak
    var followingValueLabel: UILabel!
    
    @IBOutlet weak
    var editButton: UIButton!
    
    @IBOutlet weak
    var shareButton: UIButton!
    
    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        output?.viewIsReady()
    }
    
    @IBAction
    func didTapEditButton(_ sender: UIButton) {
        output?.didOpenEdit()
    }
    
    @IBAction
    func didTapShareButton(_ sender: UIButton) {
        
    }
    
    func configure() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        editButton.layer.cornerRadius = 10
        shareButton.layer.cornerRadius = 10
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    // MARK: ProfileViewInput

    func setImage(data: Data?) {
        if let data = data {
            let image = UIImage(data: data)
            profileImageView.image = image
        }
    }
    
    func setName(name: String?) {
        nameLabel.text = name
    }
    
    func setBio(bio: String?) {
        biographyLabel.text = bio
    }
    
    
    func setupInitialState() {
    }
    
}
