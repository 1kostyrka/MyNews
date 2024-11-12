//
//  EditProfileModuleOutput.swift
//  ios-news
//
//  Created by Ivan Kostyrka on 03.09.2024.
//

import Foundation
import ViperArch

protocol EditProfileModuleOutput: ModuleOutput {
    func didEdit(data: Data?, name: String?, bio: String?) 
}
