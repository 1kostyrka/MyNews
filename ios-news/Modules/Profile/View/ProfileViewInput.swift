//
//  ProfileProfileViewInput.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

protocol ProfileViewInput: ModuleTransitionHandler {

    func setupInitialState()

    func setImage(data: Data?)
    
    func setName(name: String?)
    
    func setBio(bio: String?)
}
