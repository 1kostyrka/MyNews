//
//  ConfirmSignConfirmSignAssembly.swift
//  News
//
//  Created by Ivan Kostyrka on 09/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

final class ConfirmSignAssembly: Assembly {

    func assemble(container: Container) {

        container.storyboardInitCompleted(ConfirmSignViewController.self) { (r, view) in
            view.output = r.resolve(ConfirmSignPresenter.self, argument: view)
        }

        container.register(ConfirmSignViewController.self) { r in
            let view = ConfirmSignViewController()
            view.output = r.resolve(ConfirmSignPresenter.self, argument: view)
            return view
        }

        container.register(ConfirmSignPresenter.self) { (r, view: ConfirmSignViewController) in
            let presenter = ConfirmSignPresenter()
            let interactor = r.resolve(ConfirmSignInteractor.self, argument: presenter)!
            let router = r.resolve(ConfirmSignRouter.self, arguments: view, interactor)!
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            return presenter
        }

        container.register(ConfirmSignInteractor.self) { (r, presenter: ConfirmSignPresenter) in
            let interactor = ConfirmSignInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(ConfirmSignRouter.self) { (r, view: ConfirmSignViewController, interactor: ConfirmSignInteractor) in
            let router = ConfirmSignRouter()
            router.interactor = interactor
            router.transitionHandler = view
            return router
        }

    }

}
