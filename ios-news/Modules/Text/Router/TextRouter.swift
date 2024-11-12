//
//  TextTextRouter.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

final class TextRouter: TextRouterInput {

    weak var transitionHandler: ModuleTransitionHandler?
    var interactor: TextInteractorInput?

}
