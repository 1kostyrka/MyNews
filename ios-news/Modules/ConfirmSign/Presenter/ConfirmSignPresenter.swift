//
//  ConfirmSignConfirmSignPresenter.swift
//  News
//
//  Created by Ivan Kostyrka on 09/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

final class ConfirmSignPresenter: ModuleInput, ConfirmSignModuleInput, ConfirmSignViewOutput, ConfirmSignInteractorOutput {

    weak var view: ConfirmSignViewInput?
    var interactor: ConfirmSignInteractorInput?
    var router: ConfirmSignRouterInput?

    internal func viewIsReady() {
        view?.setupInitialState()
    }

    func set(moduleOutput: ModuleOutput) {
    }

    func configure() {
    }

    // MARK: ConfirmSignViewOutput

    // MARK: ConfirmSignInteractorOutput
}
