//
//  SignInSignInRouter.swift
//  News
//
//  Created by Ivan Kostyrka on 09/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

final class SignInRouter: SignInRouterInput {

    weak var transitionHandler: ModuleTransitionHandler?
    var interactor: SignInInteractorInput?

    enum Segues {
        case segue_login_to_register
    }
    
    func openRegister() {
        transitionHandler?.openModuleUsingSegue(withIdentifier: "segue_login_to_register").thenChain(using: { moduleInput in
            (moduleInput as? SignUpModuleInput)?.configure()
            
            return nil
        })
    }
}
