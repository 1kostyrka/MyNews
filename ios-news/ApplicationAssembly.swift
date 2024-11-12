//
//  ApplicationAssembly.swift
//  ios-auto-report
//
//  Created by Oleh Kulakevych on 29.12.2023.
//

import Foundation
import Swinject
import SwinjectStoryboard

fileprivate var assembler: Assembler!

extension SwinjectStoryboard {
    
    @objc
    class func setup() {
        Container.loggingFunction = nil
        
        let assemblies: [Assembly] = [
            HelpersAssembly(),
            DashboardAssembly(),
            RootAssembly(),
            MediaAssembly(),
            TextAssembly(),
            SavedAssembly(),
            ProfileAssembly(),
            NewsWebAssembly(),
            EditProfileAssembly(),
            NewsProfileAssembly(),
            MediaPostsAssembly(),
            SignInAssembly(),
            SignUpAssembly(),
            ConfirmSignAssembly(),
            SelectedNewsAssembly(),
        ]
        assembler = Assembler(assemblies, container: defaultContainer)
    }
}
