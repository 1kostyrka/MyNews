//
//  DashboardDashboardAssembly.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

final class DashboardAssembly: Assembly {

    func assemble(container: Container) {

        container.storyboardInitCompleted(DashboardViewController.self) { (r, view) in
            view.output = r.resolve(DashboardPresenter.self, argument: view)
        }

        container.register(DashboardViewController.self) { r in
            let view = DashboardViewController()
            view.output = r.resolve(DashboardPresenter.self, argument: view)
            return view
        }

        container.register(DashboardPresenter.self) { (r, view: DashboardViewController) in
            let presenter = DashboardPresenter()
            let interactor = r.resolve(DashboardInteractor.self, argument: presenter)!
            let router = r.resolve(DashboardRouter.self, arguments: view, interactor)!
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            return presenter
        }

        container.register(DashboardInteractor.self) { (r, presenter: DashboardPresenter) in
            let interactor = DashboardInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(DashboardRouter.self) { (r, view: DashboardViewController, interactor: DashboardInteractor) in
            let router = DashboardRouter()
            router.interactor = interactor
            router.transitionHandler = view
            return router
        }

    }

}
