//
//  MediaPostsMediaPostsPresenter.swift
//  News
//
//  Created by Ivan Kostyrka on 04/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch
import FeedKit

final class MediaPostsPresenter: ModuleInput, MediaPostsModuleInput, MediaPostsViewOutput, MediaPostsInteractorOutput {
    
    weak var view: MediaPostsViewInput?
    var interactor: MediaPostsInteractorInput?
    var router: MediaPostsRouterInput?
    
    var feed: RSSFeed?
    
    
    var feedUnwrapp: [RSSFeedItem] {
        return feed?.items ?? []
    }
    
    var news: [NewsStorage] = [
        NewsStorage(
            title: "Вимкнення електроенергії на Львівщині",
            description: "Завтра, 2 вересня, на території Львівської області графіки погодинних вимкнень діятимуть протягом всієї доби.",
            image: "https://cdn4.suspilne.media/images/resize/794x1.78/c66709fa8bf38e19.jpg", link: "https://24tv.ua/rosiya-zavdala-udaru-raketoyu-48n6dm-po-kiyevu-2-veresnya-shho_n2632444"
        ),
        NewsStorage(
            title: "Міжнародний економічний форум у Львові",
            description: "У Львові відбувся Міжнародний економічний форум, на якому обговорювались інвестиції у регіон.",
            image: "https://lcci.com.ua/wp-content/uploads/2021/11/IMG_5845.jpg", link: "https://glavcom.ua/world/world-politics/prezident-monholiji-poklikav-putina-u-jurtu-vich-na-vich-1018553.html"
        ),
        NewsStorage(
            title: "Новий туристичний маршрут у Карпатах",
            description: "На Львівщині відкрили новий туристичний маршрут у Карпатах, що веде до мальовничих водоспадів.",
            image: "https://7cars.com.ua/wp-content/uploads/2019/03/Carpathian-mountains.jpg", link: "https://www.epravda.com.ua/news/2024/09/3/718818/"
        ),
        NewsStorage(
            title: "Ремонт доріг у Львові",
            description: "У Львові розпочато масштабний ремонт доріг, що охопить основні транспортні артерії міста.",
            image: "https://static.espreso.tv/uploads/photobank/350000_351000/350997_4092912219054677528662055283117770479763456n-9e3b2220_new_960x500_0.webp", link: "https://espreso.tv/viyna-z-rosiyeyu-nachshtabu-azovu-krotevich-rozpoviv-yaki-plani-u-rosiyan-yakshcho-voni-okupuyut-pokrovsk"
        ),
        NewsStorage(
            title: "Львів святкує День міста",
            description: "Цими вихідними Львів святкує День міста з концертами, ярмарками та вуличними виставами.",
            image: "https://cdn4.suspilne.media/images/resize/1040x1.78/dc1fa9389c9bbf74.jpg", link: "https://suspilne.media/poltava/827515-vibuh-u-poltavi-3-veresna-2024-so-vidomo/"
        ),
        NewsStorage(
            title: "Відкриття нового мистецького центру у Львові",
            description: "У Львові відкрився новий мистецький центр, де відбуватимуться виставки сучасного мистецтва.",
            image: "https://static.espreso.tv/uploads/photobank/313000_314000/313222_facadeafterrestaurationphotobynazariyparkhomyk-8252238d_new_960x380_0.webp", link: "https://tsn.ua/svit/droni-atakuvali-viyskoviy-aerodrom-u-rosiyskiy-tveri-2652387.html"
        ),
        NewsStorage(
            title: "Підтримка ЗСУ від львівських волонтерів",
            description: "Львівські волонтери зібрали гуманітарну допомогу для військових на передовій.",
            image: "https://portal.lviv.ua/wp-content/uploads/2022/09/600.jpg", link: "https://www.pravda.com.ua/news/2024/09/3/7473219/"
        ),
        NewsStorage(
            title: "Зелені зони Львова",
            description: "Міська влада планує створити нові зелені зони у Львові для відпочинку мешканців.",
            image: "https://sadovyi.org/wp-content/uploads/2024/05/879244be284f6832aed5743b19734f17_w960.jpg", link: "https://www.epravda.com.ua/news/2024/09/3/718820/"
        )
    ]
    
    var medias: [MediaStorage] = SubscriveService.shared.medias
    
    internal func viewIsReady() {
        view?.setupInitialState()
    }
    
    func set(moduleOutput: ModuleOutput) {
    }
    
    func configure() {
    }
    
    func configure(feed: RSSFeed) {
        self.feed = feed
    }
    
    // MARK: MediaPostsViewOutput
    
    func didSelectRow(index: Int) {
        let link = news[index].link
        router?.openWeb(link: link)
    }
    
    // MARK: MediaPostsInteractorOutput
}
