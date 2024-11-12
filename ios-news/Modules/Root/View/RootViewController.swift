//
//  RootRootViewController.swift
//  News
//
//  Created by Ivan Kostyrka on 31/08/2024.
//  Copyright © 2024 Ivan Kostyrka. All rights reserved.
//

import UIKit
import CardTabBar

final class RootViewController: CardTabBarController, RootViewInput {
    
    var output: RootViewOutput?
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewController()
        output?.viewIsReady()
    }
    
    func setupUI() {
        tabBar.tintColor = .black
        tabBar.backgroundColor = .clear
        tabBar.barTintColor = .systemGray6
        tabBar.indicatorColor = .black
        tabBar.itemSpacing = 2
        
    }
    
    func setupViewController() {
        
        let storyboard0 = UIStoryboard(name: "Sign", bundle: nil)
        let controller0 = storyboard0.instantiateViewController(identifier: "SignInViewController")
        
        let storyboard1 = UIStoryboard(name: "Main", bundle: nil)
        let controller1 = storyboard1.instantiateViewController(identifier: "DashboardViewController")
        controller1.view.backgroundColor = .white
        controller1.title = "Головна"
        let largeConfig1 = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let image1 = UIImage(systemName: "newspaper", withConfiguration: largeConfig1)
        image1?.withTintColor(.black, renderingMode: .alwaysTemplate)
        controller1.tabBarItem.image = image1
        
        
        let storyboard2 = UIStoryboard(name: "Media", bundle: nil)
        let controller2 = storyboard2.instantiateViewController(identifier: "MediaModule")
        controller2.view.backgroundColor = .orange
        controller2.title = "Медіа"
        let largeConfig2 = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let image2 = UIImage(systemName: "tv.and.mediabox", withConfiguration: largeConfig2)
        controller2.tabBarItem.image = image2
        image2?.withTintColor(.black, renderingMode: .alwaysTemplate)
        
        let storyaboard3 = UIStoryboard(name: "Text", bundle: nil)
        let controller3 = storyaboard3.instantiateViewController(identifier: "TextViewController")
        controller3.view.backgroundColor = .white
        controller3.title = "Написати"
        let largeConfig3 = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let image3 = UIImage(systemName: "text.bubble", withConfiguration: largeConfig3)
        controller3.tabBarItem.image = image3
        image3?.withTintColor(.black, renderingMode: .alwaysTemplate)
        
        
        let storyboard4 = UIStoryboard(name: "Saved", bundle: nil)
        let controller4 = storyboard4.instantiateViewController(identifier: "SavedViewController")
        controller4.view.backgroundColor = .white
        controller4.title = "Збережене"
        let largeConfig4 = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let image4 = UIImage(systemName: "square.and.arrow.down", withConfiguration: largeConfig4)
        controller4.tabBarItem.image = image4
        image4?.withTintColor(.black, renderingMode: .alwaysTemplate)
    
        let storyboard5 = UIStoryboard(name: "Profile", bundle: nil)
        let controller5 = storyboard5.instantiateViewController(identifier: "ProfileViewController")
        controller5.view.backgroundColor = .white
        controller5.title = "Профіль"
        let largeConfig5 = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let image5 = UIImage(systemName: "person.crop.circle", withConfiguration: largeConfig5)
        controller5.tabBarItem.image = image5
        image5?.withTintColor(.black, renderingMode: .alwaysTemplate)
        
        viewControllers = [UINavigationController(rootViewController: controller1), controller2, UINavigationController(rootViewController: controller3), UINavigationController(rootViewController: controller4), UINavigationController(rootViewController: controller5)]
    }
    
    // MARK: RootViewInput
    
    func setupInitialState() {
    }
    
}
