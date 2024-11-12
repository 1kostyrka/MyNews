//
//  SignUpSignUpAssembly.swift
//  News
//
//  Created by Ivan Kostyrka on 09/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

final class SignUpAssembly: Assembly {

    func assemble(container: Container) {

        container.storyboardInitCompleted(SignUpViewController.self) { (r, view) in
            view.output = r.resolve(SignUpPresenter.self, argument: view)
        }

        container.register(SignUpViewController.self) { r in
            let view = SignUpViewController()
            view.output = r.resolve(SignUpPresenter.self, argument: view)
            return view
        }

        container.register(SignUpPresenter.self) { (r, view: SignUpViewController) in
            let presenter = SignUpPresenter()
            let interactor = r.resolve(SignUpInteractor.self, argument: presenter)!
            let router = r.resolve(SignUpRouter.self, arguments: view, interactor)!
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            return presenter
        }

        container.register(SignUpInteractor.self) { (r, presenter: SignUpPresenter) in
            let interactor = SignUpInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(SignUpRouter.self) { (r, view: SignUpViewController, interactor: SignUpInteractor) in
            let router = SignUpRouter()
            router.interactor = interactor
            router.transitionHandler = view
            return router
        }

    }

}
