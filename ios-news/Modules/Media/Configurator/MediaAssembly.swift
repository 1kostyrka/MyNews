//
//  MediaMediaAssembly.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

final class MediaAssembly: Assembly {

    func assemble(container: Container) {

        container.storyboardInitCompleted(MediaViewController.self) { (r, view) in
            view.output = r.resolve(MediaPresenter.self, argument: view)
        }

        container.register(MediaViewController.self) { r in
            let view = MediaViewController()
            view.output = r.resolve(MediaPresenter.self, argument: view)
            return view
        }

        container.register(MediaPresenter.self) { (r, view: MediaViewController) in
            let presenter = MediaPresenter()
            let interactor = r.resolve(MediaInteractor.self, argument: presenter)!
            let router = r.resolve(MediaRouter.self, arguments: view, interactor)!
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            return presenter
        }

        container.register(MediaInteractor.self) { (r, presenter: MediaPresenter) in
            let interactor = MediaInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(MediaRouter.self) { (r, view: MediaViewController, interactor: MediaInteractor) in
            let router = MediaRouter()
            router.interactor = interactor
            router.transitionHandler = view
            return router
        }

    }

}
