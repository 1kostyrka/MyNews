//
//  RootRootAssembly.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

final class RootAssembly: Assembly {

    func assemble(container: Container) {

        container.storyboardInitCompleted(RootViewController.self) { (r, view) in
            view.output = r.resolve(RootPresenter.self, argument: view)
        }

        container.register(RootViewController.self) { r in
            let view = RootViewController()
            view.output = r.resolve(RootPresenter.self, argument: view)
            return view
        }

        container.register(RootPresenter.self) { (r, view: RootViewController) in
            let presenter = RootPresenter()
            let interactor = r.resolve(RootInteractor.self, argument: presenter)!
            let router = r.resolve(RootRouter.self, arguments: view, interactor)!
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            return presenter
        }

        container.register(RootInteractor.self) { (r, presenter: RootPresenter) in
            let interactor = RootInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(RootRouter.self) { (r, view: RootViewController, interactor: RootInteractor) in
            let router = RootRouter()
            router.interactor = interactor
            router.transitionHandler = view
            return router
        }

    }

}
