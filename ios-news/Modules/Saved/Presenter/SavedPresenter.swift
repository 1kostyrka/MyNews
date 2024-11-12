//
//  SavedSavedPresenter.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

final class SavedPresenter: ModuleInput, SavedModuleInput, SavedViewOutput, SavedInteractorOutput {
    
    weak var view: SavedViewInput?
    var interactor: SavedInteractorInput?
    var router: SavedRouterInput?
    
    var link: String?
    
    var news: [NewsStorage] = SubscriveService.shared.news
    
    var savedNews: [NewsStorage] = []
    
    var medias: [MediaStorage] = SubscriveService.shared.medias
    
    internal func viewIsReady() {
        view?.setupInitialState()
    }
    
    func set(moduleOutput: ModuleOutput) {
    }
    
    func configure() {
    }
    
   
    
    // MARK: SavedViewOutput
    
    func didSelectPage(index: Int) {
        let link = news[index].link
        router?.openWeb(link: link)
    }
    
    // MARK: SavedInteractorOutput
}
