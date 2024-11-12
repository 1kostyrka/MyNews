//
//  MediaMediaPresenter.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch
import FeedKit

final class MediaPresenter: ModuleInput, MediaModuleInput, MediaViewOutput, MediaInteractorOutput {
    
    weak var view: MediaViewInput?
    var interactor: MediaInteractorInput?
    var router: MediaRouterInput?
    
    var medias: [MediaStorage] {
        return SubscriveService.shared.medias
    }
    
    internal func viewIsReady() {
        view?.setupInitialState()
    }
    
    func set(moduleOutput: ModuleOutput) {
    }
    
    func configure() {
    }
    
    // MARK: MediaViewOutput
    
    func didTapMedia(index: Int) {
        guard let rssLink = medias[index].rss, !rssLink.isEmpty else {
            return
        }
        guard let feedURL = URL(string: rssLink) else {
            return
        }
        let parser = FeedParser(URL: feedURL)
        
        parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
            switch result {
            case .success(let feed):
                switch feed {
                case let .atom(feed): break
                case let .rss(feed):
                    print(feed.items?.first?.media)
                    self.router?.openFeed(with: feed)
                case let .json(feed): break
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    // MARK: MediaInteractorOutput
}
