//
//  SelectedNewsSelectedNewsViewOutput.swift
//  News
//
//  Created by Ivan Kostyrka on 16/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

protocol SelectedNewsViewOutput: ModuleInput, SelectedNewsModuleInput {

    func viewIsReady()
    
    func saveNews(_ news: NewsStorage)
    
    func removeSavedNews(_ news: NewsStorage)
    
    func isNewsSaved(_ news: NewsStorage) -> Bool
    
    func saveNewsToUserDefaults()
    
    func loadSavedNews()
    
    var news: [NewsStorage] { get }
    
    var savedNews: [NewsStorage] { get set }
    
    var selectedNews: NewsStorage? { get }

}
