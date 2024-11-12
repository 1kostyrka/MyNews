//
//  ProfileDataSource.swift
//  ios-news
//
//  Created by Ivan Kostyrka on 03.09.2024.
//

import UIKit

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output?.news.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        cell.set(image: output?.news[indexPath.item].image ?? "")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width - 1
        let itemSize = collectionViewSize / 3
        return CGSize(width: itemSize, height: itemSize)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.3
    }
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        return configureContextMenu(index: indexPaths.first?.row ?? 0)
    }
    
    func configureContextMenu(index: Int) -> UIContextMenuConfiguration {
        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            
            let edit = UIAction(title: "Редагувати", image: UIImage(systemName: "square.and.pencil"), identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in
                
            }
            let delete = UIAction(title: "Видалити", image: UIImage(systemName: "trash"), identifier: nil, discoverabilityTitle: nil,attributes: .destructive, state: .off) { (_) in [self]
                self.output?.news.remove(at: index)
                
                self.collectionView.performBatchUpdates({
                    self.collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
                }, completion: nil)
            }
            
            let like = UIAction(title: self.output?.news[index].isLiked == true ? "Не подобаєтся" : "Подобаєтся", image: UIImage(systemName: self.output?.news[index].isLiked == true ? "heart.fill" : "heart"), identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in
                if let isLiked = self.output?.news[index].isLiked, isLiked {
                    
                    self.output?.news[index].isLiked = false
                    self.output?.news[index].likedCount? -= 1
                } else {
                    self.output?.news[index].isLiked = true
                    self.output?.news[index].likedCount? += 1
                }
                
                self.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            }
            
            return UIMenu(title: "Опції", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [edit, like, delete])
            
        }
        return context
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if var viewedCount = output?.news[indexPath.row].viewedCount {
            viewedCount += 1
            output?.news[indexPath.row].viewedCount = viewedCount
        } else {
            output?.news[indexPath.row].viewedCount = 1
        }
        
        output?.news.sort {($0.viewedCount ?? 0) > ($1.viewedCount ?? 0)}
           collectionView.reloadData()
        
        output?.didSelectPage(index: indexPath.row)
    }
}
