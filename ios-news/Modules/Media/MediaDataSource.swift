//
//  MediaDataSource.swift
//  ios-news
//
//  Created by Ivan Kostyrka on 31.08.2024.
//

import UIKit

extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output?.medias.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell") as! MediaTableViewCell
        if let media = output?.medias[indexPath.row] {
            cell.set(image: media.image, text: media.title)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.didTapMedia(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            
            let isSubcribed = self.output?.medias[indexPath.row].isSubscribed
            
            let subscribe = UIAction(title: (isSubcribed ?? false) ? "Відписатись" : "Підписатись", image: UIImage(systemName: "plus.circle"), identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in
                if self.output?.medias[indexPath.row].isSubscribed ?? false {
                    SubscriveService.shared.removeSub(id: self.output?.medias[indexPath.row].id ?? -1)
                    self.tableView.reloadData()
                } else {
                    SubscriveService.shared.addSub(id: self.output?.medias[indexPath.row].id ?? -1)
                    self.tableView.reloadData()
                }
            }
            
            
            return UIMenu(title: "Опції", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [subscribe])
            
        }
        return context
    }
}
