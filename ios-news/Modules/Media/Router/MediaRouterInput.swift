//
//  MediaMediaRouterInput.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import FeedKit

protocol MediaRouterInput {

    func openFeed(with: RSSFeed)
}
