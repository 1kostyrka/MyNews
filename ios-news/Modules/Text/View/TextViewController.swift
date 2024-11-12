//
//  TextTextViewController.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

final class TextViewController: UIViewController, TextViewInput {
    
    var output: TextViewOutput?
    
    @IBOutlet weak
    var nameTextField: UITextField!
    @IBOutlet weak
    var titleTextField: UITextField!
    
    @IBOutlet weak
    var textView: UITextView!
    
    @IBOutlet weak
    var containerView: UIView!
    
    @IBOutlet weak
    var sendButton: UIButton!
    @IBOutlet weak
    var addPhotoButton: UIButton!
    
    var isPhotoAdded = false
    var selectedImage: UIImage?
    
    var news: [NewsStorage] = SubscriveService.shared.news
    
    private var imageService = ImageService()
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        output?.viewIsReady()
    }
    
    func configure() {
        sendButton.layer.cornerRadius = 10
        
        containerView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 5
        
        imageService.delegate = self
    }
    
    @IBAction
    func didTapSendButton(_ sender: UIButton) {
        guard let title = titleTextField.text, !title.isEmpty,
              let description = textView.text, !description.isEmpty else {
            showAlert("Заповніть усі поля")
            return
        }
        
        let defaultImage = "https://i.pinimg.com/564x/a1/cd/44/a1cd44f6617beebb9794877ef59082a1.jpg"
        let newNews = NewsStorage(
            title: title,
            description: description,
            image: nil,
            link: "",
            isLiked: false,
            likedCount: 0,
            viewedCount: 0,
            id: 9,
            localImage: selectedImage?.jpegData(compressionQuality: 1)
        )
        
        SubscriveService.shared.news.append(newNews)
        print(newNews)
        
        nameTextField.text = ""
        titleTextField.text = ""
        textView.text = ""
        removePhoto()
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Помилка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func didTapAddPhotoButton(_ sender: UIButton) {
        if isPhotoAdded {
            removePhoto()
        } else {
            selectPhotoOption()
        }
    }
    
    func removePhoto() {
        isPhotoAdded = false
        selectedImage = nil
        addPhotoButton.setTitle("Додати фото", for: .normal)
    }
    
    // MARK: TextViewInput
    
    func setupInitialState() {
    }
    
}

extension TextViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
            isPhotoAdded = true
            addPhotoButton.setTitle("Видалити фото", for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension TextViewController {
    
    func selectPhotoOption() {
        if #available(iOS 14, *) {
            let photos = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            
            if photos == .authorized || photos == .limited {
                self.presentGalery()
            } else if photos == .notDetermined {
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
                    switch status {
                    case .authorized, .limited:
                        self?.presentGalery()
                    case .denied, .restricted:
                        self?.presentGaleryWarning()
                    default:
                        self?.presentGaleryWarning()
                    }
                }
            } else {
                self.presentGaleryWarning()
            }
        } else {
            let photos = PHPhotoLibrary.authorizationStatus()
            
            if photos == .authorized {
                self.presentGalery()
            } else if photos == .notDetermined {
                PHPhotoLibrary.requestAuthorization( { [weak self] status in
                    switch status {
                    case .authorized, .limited:
                        self?.presentGalery()
                    case .denied, .restricted:
                        self?.presentGaleryWarning()
                    default:
                        self?.presentGaleryWarning()
                    }
                })
            } else {
                self.presentGaleryWarning()
            }
        }
    }
    
    private func presentGalery() {
        let alertController = UIAlertController(title: "Додати фото", message: "Оберіть один з варіантів додавання фото", preferredStyle: .actionSheet)
        
        let gallery = UIAlertAction(title: "Обрати з галереї", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.imageService.openPhotoLibraryBasic(contoller: self, filter: .image, limit: 1)
        })
        let camera = UIAlertAction(title: "Зробити фото", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.imageService.openCamera(controller: self)
        })
        let cancel = UIAlertAction(title: "Скасувати", style: .cancel)
        alertController.addAction(gallery)
        alertController.addAction(camera)
        alertController.addAction(cancel)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
    
    private func presentGaleryWarning() {
        let alertController = UIAlertController(title: "Помилка при додаванні фото", message: "Не вдалося отримати доступ до фотогалереї. Вам потрібно перейти в загальні налаштування додатка на iOS і дозволити доступ до фото.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Скасувати", style: .cancel)
        alertController.addAction(cancel)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}

extension TextViewController: ImageServiceDelegate {
    
    func didFinishPicking(image: [ImageService.ImageServicePhotoObject], video: [ImageService.ImageServiceVideoObject]) {
        guard let first = image.first?.image else { return }
        selectedImage = first
        isPhotoAdded = true
        addPhotoButton.setTitle("Видалити фото", for: .normal)
    }
    
    func didFinishPickingCanceled(error: Error?, message: String?) {
    }
}
