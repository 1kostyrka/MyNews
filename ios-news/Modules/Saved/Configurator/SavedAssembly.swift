//
//  SavedSavedAssembly.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

final class SavedAssembly: Assembly {

    func assemble(container: Container) {

        container.storyboardInitCompleted(SavedViewController.self) { (r, view) in
            view.output = r.resolve(SavedPresenter.self, argument: view)
        }

        container.register(SavedViewController.self) { r in
            let view = SavedViewController()
            view.output = r.resolve(SavedPresenter.self, argument: view)
            return view
        }

        container.register(SavedPresenter.self) { (r, view: SavedViewController) in
            let presenter = SavedPresenter()
            let interactor = r.resolve(SavedInteractor.self, argument: presenter)!
            let router = r.resolve(SavedRouter.self, arguments: view, interactor)!
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            return presenter
        }

        container.register(SavedInteractor.self) { (r, presenter: SavedPresenter) in
            let interactor = SavedInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(SavedRouter.self) { (r, view: SavedViewController, interactor: SavedInteractor) in
            let router = SavedRouter()
            router.interactor = interactor
            router.transitionHandler = view
            return router
        }

    }

}
