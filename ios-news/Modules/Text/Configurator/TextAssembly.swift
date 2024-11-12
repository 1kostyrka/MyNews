//
//  TextTextAssembly.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

final class TextAssembly: Assembly {

    func assemble(container: Container) {

        container.storyboardInitCompleted(TextViewController.self) { (r, view) in
            view.output = r.resolve(TextPresenter.self, argument: view)
        }

        container.register(TextViewController.self) { r in
            let view = TextViewController()
            view.output = r.resolve(TextPresenter.self, argument: view)
            return view
        }

        container.register(TextPresenter.self) { (r, view: TextViewController) in
            let presenter = TextPresenter()
            let interactor = r.resolve(TextInteractor.self, argument: presenter)!
            let router = r.resolve(TextRouter.self, arguments: view, interactor)!
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            return presenter
        }

        container.register(TextInteractor.self) { (r, presenter: TextPresenter) in
            let interactor = TextInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(TextRouter.self) { (r, view: TextViewController, interactor: TextInteractor) in
            let router = TextRouter()
            router.interactor = interactor
            router.transitionHandler = view
            return router
        }

    }

}
