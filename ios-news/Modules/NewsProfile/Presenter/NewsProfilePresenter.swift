//
//  NewsProfileNewsProfilePresenter.swift
//  News
//
//  Created by Ivan Kostyrka on 04/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

final class NewsProfilePresenter: ModuleInput, NewsProfileModuleInput, NewsProfileViewOutput, NewsProfileInteractorOutput {
    
    weak var view: NewsProfileViewInput?
    var interactor: NewsProfileInteractorInput?
    var router: NewsProfileRouterInput?
    
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
    
    // MARK: NewsProfileViewOutput
    
    
    
    // MARK: NewsProfileInteractorOutput
}
