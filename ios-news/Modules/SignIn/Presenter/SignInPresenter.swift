//
//  SignInSignInPresenter.swift
//  News
//
//  Created by Ivan Kostyrka on 09/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

final class SignInPresenter: ModuleInput, SignInModuleInput, SignInViewOutput, SignInInteractorOutput {

    weak var view: SignInViewInput?
    var interactor: SignInInteractorInput?
    var router: SignInRouterInput?

    internal func viewIsReady() {
        view?.setupInitialState()
    }

    func set(moduleOutput: ModuleOutput) {
    }

    func configure() {
    }

    // MARK: SignInViewOutput
    
    func didOpenRegister() {
        router?.openRegister()
    }

    // MARK: SignInInteractorOutput
}
