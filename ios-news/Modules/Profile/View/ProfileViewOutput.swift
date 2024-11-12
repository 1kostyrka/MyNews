//
//  ProfileProfileViewOutput.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

protocol ProfileViewOutput: ModuleInput, ProfileModuleInput {

    var news: [NewsStorage] { get set }
    
    func viewIsReady()

    func didOpenEdit()
    
    func didSelectPage(index: Int)
}
