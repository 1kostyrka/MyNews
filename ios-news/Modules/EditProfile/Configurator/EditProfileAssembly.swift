//
//  EditProfileEditProfileAssembly.swift
//  News
//
//  Created by Ivan Kostyrka on 03/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

final class EditProfileAssembly: Assembly {

    func assemble(container: Container) {

        container.storyboardInitCompleted(EditProfileViewController.self) { (r, view) in
            view.output = r.resolve(EditProfilePresenter.self, argument: view)
        }

        container.register(EditProfileViewController.self) { r in
            let view = EditProfileViewController()
            view.output = r.resolve(EditProfilePresenter.self, argument: view)
            return view
        }

        container.register(EditProfilePresenter.self) { (r, view: EditProfileViewController) in
            let presenter = EditProfilePresenter()
            let interactor = r.resolve(EditProfileInteractor.self, argument: presenter)!
            let router = r.resolve(EditProfileRouter.self, arguments: view, interactor)!
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            return presenter
        }

        container.register(EditProfileInteractor.self) { (r, presenter: EditProfilePresenter) in
            let interactor = EditProfileInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(EditProfileRouter.self) { (r, view: EditProfileViewController, interactor: EditProfileInteractor) in
            let router = EditProfileRouter()
            router.interactor = interactor
            router.transitionHandler = view
            return router
        }

    }

}
