//
//  NewsWebNewsWebPresenter.swift
//  News
//
//  Created by Ivan Kostyrka on 03/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

final class NewsWebPresenter: ModuleInput, NewsWebModuleInput, NewsWebViewOutput, NewsWebInteractorOutput {

    weak var view: NewsWebViewInput?
    var interactor: NewsWebInteractorInput?
    var router: NewsWebRouterInput?

    var link: String?
    
    internal func viewIsReady() {
        view?.setupInitialState()
    }

    func set(moduleOutput: ModuleOutput) {
    }

    func configure() {
    }
    
    func configure(link: String) {
        self.link = link
    }

    // MARK: NewsWebViewOutput

    // MARK: NewsWebInteractorOutput
}
