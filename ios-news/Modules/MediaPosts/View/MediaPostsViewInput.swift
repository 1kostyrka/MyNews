//
//  MediaPostsMediaPostsViewInput.swift
//  News
//
//  Created by Ivan Kostyrka on 04/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

protocol MediaPostsViewInput: ModuleTransitionHandler {

    func setupInitialState()
    func reload()
}
