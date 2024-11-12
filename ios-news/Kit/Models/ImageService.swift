//
//  ImageService.swift
//  ios-news
//
//  Created by Oleh Kulakevych on 18.03.2024.
//

import UIKit
import PhotosUI
import Photos
import AVFoundation
import MobileCoreServices

protocol ImageServiceDelegate: AnyObject {
    func didFinishPicking(image: [ImageService.ImageServicePhotoObject], video: [ImageService.ImageServiceVideoObject])
    func didFinishPickingCanceled(error: Error?, message: String?)
}

extension ImageServiceDelegate {
    func didFinishPicking(image: [ImageService.ImageServicePhotoObject], video: [ImageService.ImageServiceVideoObject]) {}
}

protocol ImageServiceMedia {
    var id: UUID { get set }
}

extension ImageService {
    enum ImageType {
        case image
        case video
        case all
    }
    
    struct ImageServicePhotoObject: ImageServiceMedia {
        var id: UUID
        let image: UIImage
        
        init(image: UIImage) {
            self.id = UUID()
            self.image = image
        }
    }
    
    struct ImageServiceLibraryObject: ImageServiceMedia {
        var id: UUID
        let site: String
        let src: String
        
        init(src: String, site: String) {
            self.id = UUID()
            self.src = src
            self.site = site
        }
    }
    
    struct ImageServiceVideoObject: ImageServiceMedia {
        var id: UUID
        let preview: UIImage?
        let data: Data
        
        init(preview: UIImage?, data: Data) {
            self.id = UUID()
            self.preview = preview
            self.data = data
        }
    }
}

final class ImageService: NSObject {
    
    weak var delegate: ImageServiceDelegate?
    private var fileSize: UInt64 = 20
    
    func openCamera(controller: UIViewController, mode: UIImagePickerController.CameraCaptureMode = .photo) {
        if UIImagePickerController.isCameraDeviceAvailable(.front) || UIImagePickerController.isCameraDeviceAvailable(.rear) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.modalPresentationStyle = .fullScreen
            
            // Встановлюємо mediaTypes в залежності від режиму
            if mode == .video {
                imagePicker.mediaTypes = [kUTTypeMovie as String] // Додаємо підтримку відео
            } else {
                imagePicker.mediaTypes = [kUTTypeImage as String] // Підтримка фото
            }
            
            imagePicker.cameraCaptureMode = mode
            
            controller.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func openPhotoLibraryBasic(contoller: UIViewController, filter: ImageService.ImageType = .all, limit: Int = 1, maxSize: UInt64 = 100) {
        
        self.fileSize = maxSize
        
        if #available(iOS 14, *) {
            var latestPHPickerConfiguration = PHPickerConfiguration()
            latestPHPickerConfiguration.selectionLimit = limit
            
            if filter != .all {
                latestPHPickerConfiguration.filter = (filter == .image) ? .images : .videos
            }
            
            let latestPHPicker = PHPickerViewController(configuration: latestPHPickerConfiguration)
            latestPHPicker.delegate = self
            
            if #available(iOS 15.0, *) {
                latestPHPicker.modalPresentationStyle = .pageSheet
                if let sheetPresentationController = latestPHPicker.presentationController as? UISheetPresentationController {
                    sheetPresentationController.detents = [
                        UISheetPresentationController.Detent.medium(),
                        UISheetPresentationController.Detent.large()
                    ]
                }
            } else {
                latestPHPicker.modalPresentationStyle = .formSheet
            }
            
            contoller.present(latestPHPicker, animated: true, completion: nil)
        } else {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.modalPresentationStyle = .formSheet
            contoller.present(imagePicker, animated: true, completion: nil)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate

extension ImageService: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        DispatchQueue.main.async {
            // Перевірка, чи вибрано фото
            if let originalImage = info[.originalImage] as? UIImage {
                // Виклик делегата для фото
                self.delegate?.didFinishPicking(image: [ImageService.ImageServicePhotoObject(image: originalImage)], video: [])
            }
            
            // Перевірка, чи вибрано відео
            if let videoURL = info[.mediaURL] as? URL {
                if let videoData = try? Data(contentsOf: videoURL) {
                    let v = (ImageService.ImageServiceVideoObject(preview: self.getThumbnailImage(forUrl: videoURL), data: videoData))
                    self.delegate?.didFinishPicking(image: [], video: [v])
                }
            }
            
            // Закриваємо imagePicker
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.delegate?.didFinishPickingCanceled(error: nil, message: nil)
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
    func getThumbnailImage(forData data: Data) -> UIImage? {
        // Створюємо тимчасовий URL для роботи з AVAsset
        let tempDirectory = FileManager.default.temporaryDirectory
        let tempURL = tempDirectory.appendingPathComponent(UUID().uuidString + ".mp4")
        
        do {
            try data.write(to: tempURL)
            let asset = AVAsset(url: tempURL)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            
            do {
                let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
                return UIImage(cgImage: thumbnailImage)
            } catch let error {
                print("Помилка при створенні прев'ю: \(error)")
            }
            
            // Видаляємо тимчасовий файл після обробки
            try FileManager.default.removeItem(at: tempURL)
        } catch {
            print("Помилка при роботі з даними: \(error)")
        }
        
        return nil
    }
    
    func checkSize(url: URL?, image: UIImage?, type: ImageType) -> Bool {
        
        switch type {
        case .image:
            guard let image = image else { return false }
            guard let compress = image.jpegData(compressionQuality: 1) else { return false }
            let imgData = Data(compress)
            let imageSize: Double = (Double(imgData.count) / 1000.0) / 1024.0
            guard imageSize < Double(fileSize) else {
                return false
            }
            return true
        default:
            return false
        }
    }
}

// MARK: - PHPickerViewControllerDelegate

@available(iOS 14, *)
extension ImageService: PHPickerViewControllerDelegate {
    internal func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)
        
        if results.count > 1 {
            
            var images: [ImageService.ImageServicePhotoObject] = []
            var videos: [ImageService.ImageServiceVideoObject] = []
            var message: String?
            
            let semaphore = DispatchSemaphore(value: 0)
            let itemProviders = results.map(\.itemProvider)
            
            guard !itemProviders.isEmpty else {
                self.delegate?.didFinishPickingCanceled(error: nil, message: nil)
                return
            }
            
            for itemProvider in itemProviders {
                
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                        guard let image = image as? UIImage else { return }
                        
                        if self.checkSize(url: nil, image: image, type: .image) {
                            images.append(ImageService.ImageServicePhotoObject(image: image))
                        } else {
                            message = "One or more media exceed the allowed size"
                        }
                        
                        semaphore.signal()
                    }
                } else if itemProvider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
                    let movie = UTType.movie.identifier
                    itemProvider.loadFileRepresentation(forTypeIdentifier: movie) { [weak self] url, err in
                        guard let url = url else { return }
                        
                        if self?.checkSize(url: url, image: nil, type: .video) ?? false {
                            if let videoData = try? Data(contentsOf: url) {
                                videos.append(ImageService.ImageServiceVideoObject(preview: self?.getThumbnailImage(forUrl: url), data: videoData))
                            } else {
                                message = "One or more media exceed the allowed size"
                            }
                        } else {
                            message = "One or more media exceed the allowed size"
                            
                        }
                        
                        semaphore.signal()
                    }
                }
                
                _ = semaphore.wait(wallTimeout: .distantFuture)
            }
            
            DispatchQueue.main.async {
                if let message = message {
                    self.delegate?.didFinishPickingCanceled(error: nil, message: message)
                } else {
                    self.delegate?.didFinishPicking(image: images, video: videos)
                }
            }
        } else {
            guard let itemProvider = results.first?.itemProvider else {
                self.delegate?.didFinishPickingCanceled(error: nil, message: nil)
                return
            }
            
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                    DispatchQueue.main.async {
                        guard let self = self, let originalImage = image as? UIImage else { return }
                        
                        if self.checkSize(url: nil, image: originalImage, type: .image) {
                            DispatchQueue.main.async {
                                self.delegate?.didFinishPicking(image: [ImageService.ImageServicePhotoObject(image: originalImage)], video: [])
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.delegate?.didFinishPickingCanceled(error: nil, message: "One or more media exceed the allowed size")
                            }
                        }
                    }
                }
            } else if itemProvider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
                let movie = UTType.movie.identifier
                itemProvider.loadFileRepresentation(forTypeIdentifier: movie) { [weak self] url, err in
                    guard let url = url else { return }
                    
                    if self?.checkSize(url: url, image: nil, type: .video) ?? false {
                        let preview = self?.getThumbnailImage(forUrl: url)
                        if let videoData = try? Data(contentsOf: url) {
                            DispatchQueue.main.async {
                                self?.delegate?.didFinishPicking(image: [], video: [ImageService.ImageServiceVideoObject(preview: preview, data: videoData)])
                            }
                            
                        } else {
                            DispatchQueue.main.async {
                                self?.delegate?.didFinishPickingCanceled(error: nil, message: "One or more media exceed the allowed size")
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self?.delegate?.didFinishPickingCanceled(error: nil, message: "One or more media exceed the allowed size")
                        }
                    }
                    
                }
            } else {
                self.delegate?.didFinishPickingCanceled(error: nil, message: nil)
            }
        }
    }
}


