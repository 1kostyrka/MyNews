//
//  TextTextPresenter.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

final class TextPresenter: ModuleInput, TextModuleInput, TextViewOutput, TextInteractorOutput {

    weak var view: TextViewInput?
    var interactor: TextInteractorInput?
    var router: TextRouterInput?

    internal func viewIsReady() {
        view?.setupInitialState()
    }

    func set(moduleOutput: ModuleOutput) {
    }

    func configure() {
    }

    // MARK: TextViewOutput

    // MARK: TextInteractorOutput
}
