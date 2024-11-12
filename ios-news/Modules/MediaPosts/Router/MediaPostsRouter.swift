//
//  MediaPostsMediaPostsRouter.swift
//  News
//
//  Created by Ivan Kostyrka on 04/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

final class MediaPostsRouter: MediaPostsRouterInput {

    weak var transitionHandler: ModuleTransitionHandler?
    var interactor: MediaPostsInteractorInput?

    enum Segues {
        case segue_media_posts_to_web
    }
    
    func openWeb(link: String) {
        transitionHandler?.openModuleUsingSegue(withIdentifier: "segue_media_posts_to_web").thenChain(using: { moduleInput in
            (moduleInput as? NewsProfileModuleInput)?.configure()
            (moduleInput as? NewsProfileModuleInput)?.configure(link: link)
            
            return nil
        })
    }
    
}
