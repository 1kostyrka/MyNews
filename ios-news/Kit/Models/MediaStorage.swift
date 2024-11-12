//
//  MediaStorage.swift
//  ios-news
//
//  Created by Ivan Kostyrka on 31.08.2024.
//

import UIKit

struct MediaStorage {
    var title: String
    var image: String
    var description: String
    var location: AdressStorage
    var available: TimeStorage
    var rss: String? = nil
    var isSubscribed: Bool?
    var id: Int
    var newsIds: [Int]
}

