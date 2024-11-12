//
//  SavedSavedRouter.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

final class SavedRouter: SavedRouterInput {
    
    weak var transitionHandler: ModuleTransitionHandler?
    var interactor: SavedInteractorInput?
    
    enum Segues {
        case segue_saved_to_web
    }
    
    func openWeb(link: String) {
        transitionHandler?.openModuleUsingSegue(withIdentifier: "segue_saved_to_web").thenChain(using: { moduleInput in
            (moduleInput as? NewsProfileModuleInput)?.configure()
            (moduleInput as? NewsProfileModuleInput)?.configure(link: link)
            
            return nil
        })
    }
    
}
