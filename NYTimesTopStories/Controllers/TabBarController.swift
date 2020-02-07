//
//  TabBarController.swift
//  NYTimesTopStories
//
//  Created by Brendon Cecilio on 2/6/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit
import DataPersistence

class TabBarController: UITabBarController {
    
    private var dataPersistence = DataPersistence<Article>(filename: "savedArticles.plist")
    
    lazy private var newsFeedVC: NewsFeedController = {
        let VC = NewsFeedController()
        VC.tabBarItem = UITabBarItem(title: "News Feed", image: UIImage(systemName: "eyeglasses"), tag: 0)
        return VC
    }()
    
    lazy private var savedVC: SavedArticlesController = {
        let VC = SavedArticlesController()
        VC.tabBarItem = UITabBarItem(title: "Saved Articles", image: UIImage(systemName: "bookmark.fill"), tag: 1)
        return VC
    }()
    
    lazy private var settingsVC: SettingsController = {
        let VC = SettingsController()
        VC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        return VC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        loadTabBar()
    }
    
    private func loadTabBar() {
        viewControllers = [UINavigationController(rootViewController: newsFeedVC),
                           UINavigationController(rootViewController: savedVC),
                           UINavigationController(rootViewController: settingsVC)]
    }
}
