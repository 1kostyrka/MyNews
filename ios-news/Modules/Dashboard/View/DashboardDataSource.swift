//
//  DashboardDataSource.swift
//  ios-news
//
//  Created by Ivan Kostyrka on 05.09.2024.
//

import UIKit

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output?.news.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableViewCell") as! DashboardTableViewCell
        let item = output?.news[indexPath.row]
        cell.set(image: item?.image ?? "", title: item?.title ?? "", description: item?.description ?? "", localImage: item?.localImage)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: String(describing: SelectedNewsViewController.self)) as! SelectedNewsViewController
        if let selectedNews = output?.news[indexPath.row] {
            controller.selectedNews = selectedNews  
        }
        self.present(controller, animated: true)
    }
}
