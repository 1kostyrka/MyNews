//
//  EditProfileEditProfileViewOutput.swift
//  News
//
//  Created by Ivan Kostyrka on 03/09/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import Foundation
import ViperArch

protocol EditProfileViewOutput: ModuleInput, EditProfileModuleInput {

    func viewIsReady()
    
    func set(data: Data?, name: String?, bio: String?) 

}
