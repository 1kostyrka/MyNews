//
//  TimeStorage.swift
//  ios-news
//
//  Created by Ivan Kostyrka on 31.08.2024.
//

import UIKit

enum TimeVariation {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}
struct TimeStorage {
    let day: TimeVariation
    let openFrom: Int
    let openTo: Int
    let extra: String
}
