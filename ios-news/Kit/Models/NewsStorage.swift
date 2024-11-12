//
//  NewsStorage.swift
//  ios-news
//
//  Created by Ivan Kostyrka on 02.09.2024.
//

import UIKit

struct NewsStorage: Codable {
    var title: String
    var description: String
    var image: String?
    var link: String
    var isLiked: Bool?
    var likedCount: Int?
    var viewedCount: Int?
    var id: Int?
    var localImage: Data? = nil
}
