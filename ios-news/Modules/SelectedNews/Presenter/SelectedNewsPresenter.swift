//
//  SelectedNewsSelectedNewsPresenter.swift
//  News
//
//  Created by Ivan Kostyrka on 16/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

final class SelectedNewsPresenter: ModuleInput, SelectedNewsModuleInput, SelectedNewsViewOutput, SelectedNewsInteractorOutput {
    
    weak var view: SelectedNewsViewInput?
    var interactor: SelectedNewsInteractorInput?
    var router: SelectedNewsRouterInput?
    
    var news: [NewsStorage] = SubscriveService.shared.news
    
    var savedNews: [NewsStorage] = []
    
    var selectedNews: NewsStorage?
    
    internal func viewIsReady() {
        view?.setupInitialState()
    }
    
    func set(moduleOutput: ModuleOutput) {
    }
    
    func configure() {
    }
    
    // MARK: SelectedNewsViewOutput
    
    func saveNews(_ news: NewsStorage) {
        if !savedNews.contains(where: { $0.id == news.id }) {
            savedNews.append(news)
            saveNewsToUserDefaults()
        }
    }
    
    func removeSavedNews(_ news: NewsStorage) {
        if let index = savedNews.firstIndex(where: { $0.id == news.id }) {
            savedNews.remove(at: index)
            saveNewsToUserDefaults()
        }
    }
    
    func isNewsSaved(_ news: NewsStorage) -> Bool {
        return savedNews.contains(where: { $0.id == news.id })
    }
    
    func saveNewsToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(savedNews) {
            UserDefaults.standard.set(encoded, forKey: "savedNews")
        }
    }
    
    func loadSavedNews() {
        if let savedNewsData = UserDefaults.standard.data(forKey: "savedNews") {
            let decoder = JSONDecoder()
            if let decodedNews = try? decoder.decode([NewsStorage].self, from: savedNewsData) {
                savedNews = decodedNews
            }
        }
    }
    
    // MARK: SelectedNewsInteractorOutput
}
