//
//  SelectedNewsSelectedNewsRouter.swift
//  News
//
//  Created by Ivan Kostyrka on 16/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

final class SelectedNewsRouter: SelectedNewsRouterInput {

    weak var transitionHandler: ModuleTransitionHandler?
    var interactor: SelectedNewsInteractorInput?

}
