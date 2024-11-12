//
//  MediaMediaRouter.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch
import FeedKit

final class MediaRouter: MediaRouterInput {

    weak var transitionHandler: ModuleTransitionHandler?
    var interactor: MediaInteractorInput?

    enum Segues: String {
        case segueMediaToMediaPosts = "segue_media_to_media_posts"
        
    }
    
    func openFeed(with: RSSFeed) {
        transitionHandler?.openModuleUsingSegue(withIdentifier: Segues.segueMediaToMediaPosts.rawValue).thenChain(using: { moduleInput in
            (moduleInput as? MediaPostsModuleInput)?.configure()
            (moduleInput as? MediaPostsModuleInput)?.configure(feed: with)
            return nil
        })
    }
}
