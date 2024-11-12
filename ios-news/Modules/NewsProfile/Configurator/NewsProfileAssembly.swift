//
//  NewsProfileNewsProfileAssembly.swift
//  News
//
//  Created by Ivan Kostyrka on 04/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

final class NewsProfileAssembly: Assembly {

    func assemble(container: Container) {

        container.storyboardInitCompleted(NewsProfileViewController.self) { (r, view) in
            view.output = r.resolve(NewsProfilePresenter.self, argument: view)
        }

        container.register(NewsProfileViewController.self) { r in
            let view = NewsProfileViewController()
            view.output = r.resolve(NewsProfilePresenter.self, argument: view)
            return view
        }

        container.register(NewsProfilePresenter.self) { (r, view: NewsProfileViewController) in
            let presenter = NewsProfilePresenter()
            let interactor = r.resolve(NewsProfileInteractor.self, argument: presenter)!
            let router = r.resolve(NewsProfileRouter.self, arguments: view, interactor)!
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            return presenter
        }

        container.register(NewsProfileInteractor.self) { (r, presenter: NewsProfilePresenter) in
            let interactor = NewsProfileInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(NewsProfileRouter.self) { (r, view: NewsProfileViewController, interactor: NewsProfileInteractor) in
            let router = NewsProfileRouter()
            router.interactor = interactor
            router.transitionHandler = view
            return router
        }

    }

}
