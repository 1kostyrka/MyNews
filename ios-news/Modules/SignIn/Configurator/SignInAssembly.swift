//
//  SignInSignInAssembly.swift
//  News
//
//  Created by Ivan Kostyrka on 09/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

final class SignInAssembly: Assembly {

    func assemble(container: Container) {

        container.storyboardInitCompleted(SignInViewController.self) { (r, view) in
            view.output = r.resolve(SignInPresenter.self, argument: view)
        }

        container.register(SignInViewController.self) { r in
            let view = SignInViewController()
            view.output = r.resolve(SignInPresenter.self, argument: view)
            return view
        }

        container.register(SignInPresenter.self) { (r, view: SignInViewController) in
            let presenter = SignInPresenter()
            let interactor = r.resolve(SignInInteractor.self, argument: presenter)!
            let router = r.resolve(SignInRouter.self, arguments: view, interactor)!
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            return presenter
        }

        container.register(SignInInteractor.self) { (r, presenter: SignInPresenter) in
            let interactor = SignInInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(SignInRouter.self) { (r, view: SignInViewController, interactor: SignInInteractor) in
            let router = SignInRouter()
            router.interactor = interactor
            router.transitionHandler = view
            return router
        }

    }

}
