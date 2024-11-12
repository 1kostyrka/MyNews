//
//  SubscribeService.swift
//  ios-news
//
//  Created by Ivan Kostyrka on 05.09.2024.
//

import UIKit

class SubscriveService {
    
    private init() {
        loadSubscriptions()
    }
    static let shared = SubscriveService()
    
    private let subscriptionKey = "mediaSubscriptions"
    
    var medias: [MediaStorage] = [
        MediaStorage(
            title: "Суспільне",
            image: "https://corp.suspilne.media/media/img/11.2022/21.11.22.1.png",
            description: "Національна суспільна телерадіокомпанія України, що забезпечує доступ громадян до важливої інформації.",
            location: AdressStorage(country: "Ukraine", city: "Lviv", adress: "вул. Кн. Романа, 6", office: "Офіс 15", zip: "79000"),
            available: TimeStorage(day: .monday, openFrom: 9, openTo: 18, extra: "Вихідний: субота, неділя."), id: 0, newsIds: [0]
        ),
        MediaStorage(
            title: "ZAXID.NET",
            image: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/24_Group_Ukraine_03.png/500px-24_Group_Ukraine_03.png",
            description: "Популярне львівське інтернет-видання.",
            location: AdressStorage(country: "Ukraine", city: "Lviv", adress: "вул. Кульпарківська, 59", office: "Офіс 12", zip: "79000"),
            available: TimeStorage(day: .monday, openFrom: 9, openTo: 18, extra: "Години роботи можуть змінюватися у святкові дні."), id: 1, newsIds: [1]
        ),
        MediaStorage(
            title: "Вголос",
            image: "https://yt3.googleusercontent.com/ytc/AIdro_nqsGb7e_pQUaI1HYxia8Hlwi9bFnHIO2oTnYwGGvaa0rE=s900-c-k-c0x00ffffff-no-rj",
            description: "Незалежне львівське інтернет-видання.",
            location: AdressStorage(country: "Ukraine", city: "Lviv", adress: "пл. Ринок, 1", office: "4-й поверх", zip: "79008"),
            available: TimeStorage(day: .tuesday, openFrom: 10, openTo: 19, extra: "Вихідний: неділя."), id: 2, newsIds: [2]
        ),
        MediaStorage(
            title: "Твоє Місто",
            image: "https://tvoemisto.tv/images/catalog/intxt/images_59218.jpg",
            description: "Мультимедійний проєкт із висвітленням новин та подій.",
            location: AdressStorage(country: "Ukraine", city: "Lviv", adress: "вул. Героїв УПА, 72", office: "Офіс 7", zip: "79041"),
            available: TimeStorage(day: .wednesday, openFrom: 9, openTo: 18, extra: "Обідня перерва: з 13:00 до 14:00."), id: 3, newsIds: [3]
        ),
        MediaStorage(
            title: "032.ua",
            image: "https://pbs.twimg.com/profile_images/824532590828945412/Cqc6G84G_400x400.jpg",
            description: "Інформаційно-новинний портал Львова.",
            location: AdressStorage(country: "Ukraine", city: "Lviv", adress: "просп. Свободи, 15", office: "Офіс 5", zip: "79000"),
            available: TimeStorage(day: .thursday, openFrom: 9, openTo: 17, extra: "Працює без вихідних."), id: 4, newsIds: [4]
        ),
        MediaStorage(
            title: "Гал-інфо",
            image: "https://upload.wikimedia.org/wikipedia/commons/2/28/GinfoLogo.png",
            description: "Новинний портал з акцентом на львівські події.",
            location: AdressStorage(country: "Ukraine", city: "Lviv", adress: "вул. Костюшка, 18", office: "Офіс 2", zip: "79000"),
            available: TimeStorage(day: .friday, openFrom: 9, openTo: 18, extra: "Вихідні: субота, неділя."), id: 5, newsIds: [5]
        ),
        MediaStorage(
            title: "Львівський портал",
            image: "https://lvivhalfmarathon.org/wp-content/uploads/sites/2/2017/10/lvivskyj-portal-01.png",
            description: "Онлайн-видання з новинами Львова та області.",
            location: AdressStorage(country: "Ukraine", city: "Lviv", adress: "вул. Шевченка, 111", office: "Офіс 9", zip: "79039"),
            available: TimeStorage(day: .monday, openFrom: 8, openTo: 17, extra: "Працює без обідньої перерви."), id: 6, newsIds: [6]
        ),
        MediaStorage(
            title: "ZIK",
            image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPro4KkXifyC3L_VS8JoTQAtzVdLCyMxAVEA&s",
            description: "Телевізійний канал і новинний портал.",
            location: AdressStorage(country: "Ukraine", city: "Lviv", adress: "вул. Винниченка, 26", office: "Офіс 3", zip: "79000"),
            available: TimeStorage(day: .saturday, openFrom: 10, openTo: 17, extra: "Працює без вихідних."), id: 7, newsIds: [7]
        ),
        MediaStorage(
            title: "Конкурент",
            image: "https://cdn4.cdn-telegram.org/file/GshDctn0wY2CZ5kIyxebRv_MMRWnBaHCGDJ31j1-v8oG-R_WGYGmTmfvbfhOy6PT5LtGGO17iEMGl1RwMTJBbiKWWpigtIgm2Oi2YcP43d-8McnErSu3KHqQVbz9Mu_AGKhtmkEjqpRzTHZYK6tzUI_-mMeHy_hkzLw3ISNf2GMkhKOtQ7KFLmZAt9BaYAuJMQhSUMXO3FyXWbSCDSIu5WflhbchidozDkwBYJE-EKSb7Bc5b05rggGgUih64Yvdg9IvML4Olzf9vOASYNlymHoStAS3926T7xOUwTwMWA_qkQJ9aNoHp3lbLe9RYcul9iNp3AWWEeb9fvNTTiT4nA.jpg",
            description: "Телевізійний канал і новинний портал.",
            location: AdressStorage(country: "Ukraine", city: "Lviv", adress: "вул. Винниченка, 26", office: "Офіс 3", zip: "79000"),
            available: TimeStorage(day: .saturday, openFrom: 10, openTo: 17, extra: "Працює без вихідних."), rss: "https://konkurent.ua/rss/", id: 8, newsIds: [8]
        ),
        MediaStorage(
            title: "Моє медіа",
            image: "https://i.pinimg.com/564x/f7/47/2e/f7472e601d4f32131d0a3fae5e5c3cc3.jpg",
            description: "Новини міста Львів.",
            location: AdressStorage(country: "Ukraine", city: "Lviv", adress: "вул. Соборона, 18", office: "Офіс 6", zip: "79000"),
            available: TimeStorage(day: .saturday, openFrom: 10, openTo: 18, extra: "Працює без вихідних."), id: 9, newsIds: [9]
        )
    ]
    
    
    var news: [NewsStorage] = [
        NewsStorage(
            title: "Вимкнення електроенергії на Львівщині",
            description: "Завтра, 2 вересня, на території Львівської області графіки погодинних вимкнень діятимуть протягом всієї доби.",
            image: "https://cdn4.suspilne.media/images/resize/794x1.78/c66709fa8bf38e19.jpg", link: "https://24tv.ua/rosiya-zavdala-udaru-raketoyu-48n6dm-po-kiyevu-2-veresnya-shho_n2632444", id: 1
        ),
        NewsStorage(
            title: "Міжнародний економічний форум у Львові",
            description: "У Львові відбувся Міжнародний економічний форум, на якому обговорювались інвестиції у регіон.",
            image: "https://lcci.com.ua/wp-content/uploads/2021/11/IMG_5845.jpg", link: "https://glavcom.ua/world/world-politics/prezident-monholiji-poklikav-putina-u-jurtu-vich-na-vich-1018553.html", id: 2
        ),
        NewsStorage(
            title: "Новий туристичний маршрут у Карпатах",
            description: "На Львівщині відкрили новий туристичний маршрут у Карпатах, що веде до мальовничих водоспадів.",
            image: "https://7cars.com.ua/wp-content/uploads/2019/03/Carpathian-mountains.jpg", link: "https://www.epravda.com.ua/news/2024/09/3/718818/", id: 3
        ),
        NewsStorage(
            title: "Ремонт доріг у Львові",
            description: "У Львові розпочато масштабний ремонт доріг, що охопить основні транспортні артерії міста.",
            image: "https://static.espreso.tv/uploads/photobank/350000_351000/350997_4092912219054677528662055283117770479763456n-9e3b2220_new_960x500_0.webp", link: "https://espreso.tv/viyna-z-rosiyeyu-nachshtabu-azovu-krotevich-rozpoviv-yaki-plani-u-rosiyan-yakshcho-voni-okupuyut-pokrovsk", id: 4
        ),
        NewsStorage(
            title: "Львів святкує День міста",
            description: "Цими вихідними Львів святкує День міста з концертами, ярмарками та вуличними виставами.",
            image: "https://cdn4.suspilne.media/images/resize/1040x1.78/dc1fa9389c9bbf74.jpg", link: "https://suspilne.media/poltava/827515-vibuh-u-poltavi-3-veresna-2024-so-vidomo/", id: 5
        ),
        NewsStorage(
            title: "Відкриття нового мистецького центру у Львові",
            description: "У Львові відкрився новий мистецький центр, де відбуватимуться виставки сучасного мистецтва.",
            image: "https://static.espreso.tv/uploads/photobank/313000_314000/313222_facadeafterrestaurationphotobynazariyparkhomyk-8252238d_new_960x380_0.webp", link: "https://tsn.ua/svit/droni-atakuvali-viyskoviy-aerodrom-u-rosiyskiy-tveri-2652387.html", id: 6
        ),
        NewsStorage(
            title: "Підтримка ЗСУ від львівських волонтерів",
            description: "Львівські волонтери зібрали гуманітарну допомогу для військових на передовій.",
            image: "https://portal.lviv.ua/wp-content/uploads/2022/09/600.jpg", link: "https://www.pravda.com.ua/news/2024/09/3/7473219/", id: 7
        ),
        NewsStorage(
            title: "Зелені зони Львова",
            description: "Міська влада планує створити нові зелені зони у Львові для відпочинку мешканців.",
            image: "https://sadovyi.org/wp-content/uploads/2024/05/879244be284f6832aed5743b19734f17_w960.jpg", link: "https://www.epravda.com.ua/news/2024/09/3/718820/", id: 8
        )
    ]
    
    var savedNews: [NewsStorage] = []
    
    private func saveSubscriptions() {
        let subscribedIds = medias.filter { $0.isSubscribed ?? false }.map { $0.id }
        UserDefaults.standard.set(subscribedIds, forKey: subscriptionKey)
    }
    
    private func loadSubscriptions() {
        let subscribedIds = UserDefaults.standard.array(forKey: subscriptionKey) as? [Int] ?? []
        for id in subscribedIds {
            if let index = medias.firstIndex(where: { $0.id == id }) {
                medias[index].isSubscribed = true
            }
        }
    }
    
    func addSub(id: Int) {
        guard let firstIndex = medias.firstIndex(where: {$0.id == id}) else {
            return
        }
        medias[firstIndex].isSubscribed = true
        saveSubscriptions()
    }
    
    func removeSub(id: Int) {
        guard let firstIndex = medias.firstIndex(where: {$0.id == id}) else {
            return
        }
        medias[firstIndex].isSubscribed = false
        saveSubscriptions()
    }
    
    func mediaById(ids: [Int]) -> [NewsStorage] {
        var media: [NewsStorage] = []
        for id in ids {
            guard let item = medias.first(where: {$0.id == id}) else {
                continue
            }
            for n in news {
                if item.newsIds.contains(where: {$0 == n.id}) {
                    media.append(n)
                }
            }
        }
        return media
    }
}
