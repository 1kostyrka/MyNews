//
//  RootRootPresenter.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

final class RootPresenter: ModuleInput, RootModuleInput, RootViewOutput, RootInteractorOutput {

    weak var view: RootViewInput?
    var interactor: RootInteractorInput?
    var router: RootRouterInput?

    internal func viewIsReady() {
        view?.setupInitialState()
    }

    func set(moduleOutput: ModuleOutput) {
    }

    func configure() {
    }

    // MARK: RootViewOutput

    // MARK: RootInteractorOutput
}
