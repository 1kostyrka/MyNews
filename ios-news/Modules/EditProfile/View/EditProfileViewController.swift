//
//  EditProfileEditProfileViewController.swift
//  News
//
//  Created by Ivan Kostyrka on 03/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit

final class EditProfileViewController: UIViewController, EditProfileViewInput {
    
    var output: EditProfileViewOutput?
    
    @IBOutlet weak
    var scrollView: UIScrollView!
    
    @IBOutlet weak
    var photoImageView: UIImageView!
    
    @IBOutlet weak
    var nameTextField: UITextField!
    
    @IBOutlet weak
    var biographyTextField: UITextField!
    
    @IBOutlet weak
    var saveButton: UIButton!
    
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        photoImageView.isUserInteractionEnabled = true
        photoImageView.addGestureRecognizer(tapGestureRecognizer)
        output?.viewIsReady()
    }
    
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction
    func didTapSaveButton(_ sender: UIButton) {
        let data = photoImageView.image?.jpegData(compressionQuality: 1)
        output?.set(data: data, name: nameTextField.text, bio: biographyTextField.text)
        navigationController?.popViewController(animated: true)
    }
    
    func configure() {
        saveButton.layer.cornerRadius = 10
    }
    
    
    
    // MARK: EditProfileViewInput
    
    func setupInitialState() {
    }
    
}


extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            photoImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
