//
//  DashboardDashboardViewOutput.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

protocol DashboardViewOutput: ModuleInput, DashboardModuleInput {

    func viewIsReady()
    
    var news: [NewsStorage] { get }

}
