//
//  SelectedNewsSelectedNewsAssembly.swift
//  News
//
//  Created by Ivan Kostyrka on 16/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

final class SelectedNewsAssembly: Assembly {

    func assemble(container: Container) {

        container.storyboardInitCompleted(SelectedNewsViewController.self) { (r, view) in
            view.output = r.resolve(SelectedNewsPresenter.self, argument: view)
        }

        container.register(SelectedNewsViewController.self) { r in
            let view = SelectedNewsViewController()
            view.output = r.resolve(SelectedNewsPresenter.self, argument: view)
            return view
        }

        container.register(SelectedNewsPresenter.self) { (r, view: SelectedNewsViewController) in
            let presenter = SelectedNewsPresenter()
            let interactor = r.resolve(SelectedNewsInteractor.self, argument: presenter)!
            let router = r.resolve(SelectedNewsRouter.self, arguments: view, interactor)!
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            return presenter
        }

        container.register(SelectedNewsInteractor.self) { (r, presenter: SelectedNewsPresenter) in
            let interactor = SelectedNewsInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(SelectedNewsRouter.self) { (r, view: SelectedNewsViewController, interactor: SelectedNewsInteractor) in
            let router = SelectedNewsRouter()
            router.interactor = interactor
            router.transitionHandler = view
            return router
        }

    }

}
