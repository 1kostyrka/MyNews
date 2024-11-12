//
//  EditProfileEditProfilePresenter.swift
//  News
//
//  Created by Ivan Kostyrka on 03/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

final class EditProfilePresenter: ModuleInput, EditProfileModuleInput, EditProfileViewOutput, EditProfileInteractorOutput {

    weak var view: EditProfileViewInput?
    var interactor: EditProfileInteractorInput?
    var router: EditProfileRouterInput?
    var output: EditProfileModuleOutput?

    internal func viewIsReady() {
        view?.setupInitialState()
    }

    func set(moduleOutput: ModuleOutput) {
        self.output = moduleOutput as? EditProfileModuleOutput
    }
    

    func configure() {
    }

    // MARK: EditProfileViewOutput
    
    func set(data: Data?, name: String?, bio: String?) {
        output?.didEdit(data: data, name: name, bio: bio)
    }

    // MARK: EditProfileInteractorOutput
}
