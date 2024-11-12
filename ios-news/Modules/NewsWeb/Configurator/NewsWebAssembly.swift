//
//  NewsWebNewsWebAssembly.swift
//  News
//
//  Created by Ivan Kostyrka on 03/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

final class NewsWebAssembly: Assembly {

    func assemble(container: Container) {

        container.storyboardInitCompleted(NewsWebViewController.self) { (r, view) in
            view.output = r.resolve(NewsWebPresenter.self, argument: view)
        }

        container.register(NewsWebViewController.self) { r in
            let view = NewsWebViewController()
            view.output = r.resolve(NewsWebPresenter.self, argument: view)
            return view
        }

        container.register(NewsWebPresenter.self) { (r, view: NewsWebViewController) in
            let presenter = NewsWebPresenter()
            let interactor = r.resolve(NewsWebInteractor.self, argument: presenter)!
            let router = r.resolve(NewsWebRouter.self, arguments: view, interactor)!
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            return presenter
        }

        container.register(NewsWebInteractor.self) { (r, presenter: NewsWebPresenter) in
            let interactor = NewsWebInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(NewsWebRouter.self) { (r, view: NewsWebViewController, interactor: NewsWebInteractor) in
            let router = NewsWebRouter()
            router.interactor = interactor
            router.transitionHandler = view
            return router
        }

    }

}
