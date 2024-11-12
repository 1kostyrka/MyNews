//
//  ConfirmSignConfirmSignRouter.swift
//  News
//
//  Created by Ivan Kostyrka on 09/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

final class ConfirmSignRouter: ConfirmSignRouterInput {

    weak var transitionHandler: ModuleTransitionHandler?
    var interactor: ConfirmSignInteractorInput?

}
