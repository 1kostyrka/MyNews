//
//  MediaPostsMediaPostsViewOutput.swift
//  News
//
//  Created by Ivan Kostyrka on 04/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch
import FeedKit

protocol MediaPostsViewOutput: ModuleInput, MediaPostsModuleInput {

    func viewIsReady()
    
    var feedUnwrapp: [RSSFeedItem] { get }
    
    var medias: [MediaStorage] { get }

    func didSelectRow(index: Int)
    
}
