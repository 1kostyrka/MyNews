//
//  MediaPostsMediaPostsAssembly.swift
//  News
//
//  Created by Ivan Kostyrka on 04/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

final class MediaPostsAssembly: Assembly {

    func assemble(container: Container) {

        container.storyboardInitCompleted(MediaPostsViewController.self) { (r, view) in
            view.output = r.resolve(MediaPostsPresenter.self, argument: view)
        }

        container.register(MediaPostsViewController.self) { r in
            let view = MediaPostsViewController()
            view.output = r.resolve(MediaPostsPresenter.self, argument: view)
            return view
        }

        container.register(MediaPostsPresenter.self) { (r, view: MediaPostsViewController) in
            let presenter = MediaPostsPresenter()
            let interactor = r.resolve(MediaPostsInteractor.self, argument: presenter)!
            let router = r.resolve(MediaPostsRouter.self, arguments: view, interactor)!
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            return presenter
        }

        container.register(MediaPostsInteractor.self) { (r, presenter: MediaPostsPresenter) in
            let interactor = MediaPostsInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(MediaPostsRouter.self) { (r, view: MediaPostsViewController, interactor: MediaPostsInteractor) in
            let router = MediaPostsRouter()
            router.interactor = interactor
            router.transitionHandler = view
            return router
        }

    }

}
