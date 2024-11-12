//
//  ProfileProfileAssembly.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

final class ProfileAssembly: Assembly {

    func assemble(container: Container) {

        container.storyboardInitCompleted(ProfileViewController.self) { (r, view) in
            view.output = r.resolve(ProfilePresenter.self, argument: view)
        }

        container.register(ProfileViewController.self) { r in
            let view = ProfileViewController()
            view.output = r.resolve(ProfilePresenter.self, argument: view)
            return view
        }

        container.register(ProfilePresenter.self) { (r, view: ProfileViewController) in
            let presenter = ProfilePresenter()
            let interactor = r.resolve(ProfileInteractor.self, argument: presenter)!
            let router = r.resolve(ProfileRouter.self, arguments: view, interactor)!
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            return presenter
        }

        container.register(ProfileInteractor.self) { (r, presenter: ProfilePresenter) in
            let interactor = ProfileInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(ProfileRouter.self) { (r, view: ProfileViewController, interactor: ProfileInteractor) in
            let router = ProfileRouter()
            router.interactor = interactor
            router.transitionHandler = view
            return router
        }

    }

}
