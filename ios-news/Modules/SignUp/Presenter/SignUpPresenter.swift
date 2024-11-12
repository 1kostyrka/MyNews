//
//  SignUpSignUpPresenter.swift
//  News
//
//  Created by Ivan Kostyrka on 09/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

final class SignUpPresenter: ModuleInput, SignUpModuleInput, SignUpViewOutput, SignUpInteractorOutput {

    weak var view: SignUpViewInput?
    var interactor: SignUpInteractorInput?
    var router: SignUpRouterInput?

    internal func viewIsReady() {
        view?.setupInitialState()
    }

    func set(moduleOutput: ModuleOutput) {
    }

    func configure() {
    }

    // MARK: SignUpViewOutput

    // MARK: SignUpInteractorOutput
}
