//
//  DashboardDashboardPresenter.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

final class DashboardPresenter: ModuleInput, DashboardModuleInput, DashboardViewOutput, DashboardInteractorOutput {

    weak var view: DashboardViewInput?
    var interactor: DashboardInteractorInput?
    var router: DashboardRouterInput?
    
    var subcribed: [MediaStorage] {
        return SubscriveService.shared.medias.filter({$0.isSubscribed ?? false})
    }

    var news: [NewsStorage] {
        return SubscriveService.shared.mediaById(ids: subcribed.map({$0.id}))
    }
    
    internal func viewIsReady() {
        view?.setupInitialState()
    }

    func set(moduleOutput: ModuleOutput) {
    }

    func configure() {
    }

    // MARK: DashboardViewOutput
    
    

    // MARK: DashboardInteractorOutput
}
