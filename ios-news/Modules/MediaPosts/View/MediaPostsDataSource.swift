//
//  MediaPostsDataSource.swift
//  ios-news
//
//  Created by Ivan Kostyrka on 04.09.2024.
//

import UIKit

extension MediaPostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output?.feedUnwrapp.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaPostsTableViewCell", for: indexPath) as! MediaPostsTableViewCell
        
        let item = output?.feedUnwrapp[indexPath.row]
        
        cell.set(image: "", title: item?.title ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.didSelectRow(index: indexPath.row)
    }
}
