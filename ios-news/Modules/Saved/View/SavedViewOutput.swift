//
//  SavedSavedViewOutput.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

protocol SavedViewOutput: ModuleInput, SavedModuleInput {
    
    var news: [NewsStorage] { get }
    
    var savedNews: [NewsStorage] { get }
    
    var medias: [MediaStorage] { get }
    
    var link: String? { get }

    func viewIsReady()
    
    func didSelectPage(index: Int)

}
