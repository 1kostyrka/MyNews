//
//  MediaPostsMediaPostsModuleInput.swift
//  News
//
//  Created by Ivan Kostyrka on 04/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import FeedKit

protocol MediaPostsModuleInput: AnyObject {

	func configure()
    func configure(feed: RSSFeed)
}
