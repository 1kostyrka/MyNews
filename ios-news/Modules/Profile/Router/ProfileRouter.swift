//
//  ProfileProfileRouter.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

final class ProfileRouter: ProfileRouterInput {
    

    weak var transitionHandler: ModuleTransitionHandler?
    var interactor: ProfileInteractorInput?

    
    enum Segues: String {
        case segueProfileToEdit = "segue_profile_to_edit"
        case segueProfileToNewsProfile = "segue_profile_to_news_profile"
    }
    
    func openEdit() {
        transitionHandler?.openModuleUsingSegue(withIdentifier: Segues.segueProfileToEdit.rawValue).thenChain(using: { moduleInput in
            (moduleInput as? EditProfileModuleInput)?.configure()
            if let output = ((self.transitionHandler as? ProfileViewController)?.output as? ModuleOutput) {
                (moduleInput as? EditProfileModuleInput)?.set(moduleOutput: output)
            }
            return nil
        })
    }
    
    func openWeb(link: String) {
        transitionHandler?.openModuleUsingSegue(withIdentifier: Segues.segueProfileToNewsProfile.rawValue).thenChain(using: { moduleInput in
            (moduleInput as? NewsProfileModuleInput)?.configure()
            (moduleInput as? NewsProfileModuleInput)?.configure(link: link)
            return nil
        })
    }
}
