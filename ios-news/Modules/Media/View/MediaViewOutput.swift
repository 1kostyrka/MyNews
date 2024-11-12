//
//  MediaMediaViewOutput.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

protocol MediaViewOutput: ModuleInput, MediaModuleInput {

    var medias: [MediaStorage] { get }
    
    func viewIsReady()

    func didTapMedia(index: Int)
}
