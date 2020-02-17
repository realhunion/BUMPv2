//
//  ViewController.swift
//  BUMP
//
//  Created by Hunain Ali on 10/20/19.
//  Copyright © 2019 BUMP. All rights reserved.
//

import UIKit
import Firebase
import SwiftEntryKit

enum Tabs: Int {
    case feed = 0
    case launch = 1
    case hub = 2
}

class HomeTabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        self.delegate = self
        
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .white
        self.tabBar.barTintColor = .white
        
    }
    
    func shutDown() {
        
        feedTVC.shutDown()
//        HubTVC.shutDown()
        
    }
    
    
    
    
    var feedTVC = FeedTVC(style: .grouped)
    
    var launchVC = LaunchTVC(style: .grouped)
    
    var hubVC = HubTVC(style: .grouped)
    
    func setupTabBar() {
        
        //FIX: circle INFO large title adjustfonttoFItWidth do it.
        
        launchVC.view.backgroundColor = .white
        hubVC.view.backgroundColor = .white
        
        feedTVC.title = "My Chats"
        launchVC.title = "Start chat"
        hubVC.title = "Bump Grinnell"
        
        
        let feedNC = UINavigationController(rootViewController: feedTVC)
        let launchNC = UINavigationController(rootViewController: launchVC)
        let hubNC = UINavigationController(rootViewController: hubVC)

        feedTVC.navigationController?.navigationBar.prefersLargeTitles = true
        feedTVC.navigationController?.navigationBar.layoutMargins.left = 36
        launchVC.navigationController?.navigationBar.prefersLargeTitles = true
        launchVC.navigationController?.navigationBar.layoutMargins.left = 36
        hubVC.navigationController?.navigationBar.prefersLargeTitles = true
        hubVC.navigationController?.navigationBar.layoutMargins.left = 36
        
        feedNC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        launchNC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        hubNC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        
        let feedImage =  UIImage(named: "chatIcon")!.resizedImage(newSize: CGSize(width: 30, height: 30))
        let launchImage = UIImage(named: "peopleIcon")!.resizedImage(newSize: CGSize(width: 30, height: 30))
        let categoriesImage = UIImage(named: "heartIcon")!.resizedImage(newSize: CGSize(width: 30, height: 30))
        
        let feedItem = UITabBarItem(title: "Chats", image: feedImage, selectedImage: nil)
        let launchItem = UITabBarItem(title: "Start", image: launchImage, selectedImage: nil)
        let hubItem = UITabBarItem(title: "Bump", image: categoriesImage, selectedImage: nil)
        
        feedItem.tag = 0
        launchItem.tag = 1
        hubItem.tag = 2
        
        feedTVC.tabBarItem = feedItem
        launchVC.tabBarItem = launchItem
        hubVC.tabBarItem = hubItem
        
        let tabBarControllers = [feedNC, launchNC, hubNC]
        self.viewControllers = tabBarControllers
        self.selectedIndex = currentIndex
        
        
        
    }
    
    
    
    
    var currentIndex : Int = Tabs.feed.rawValue
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        currentIndex = selectedIndex
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        
        if selectedIndex == Tabs.feed.rawValue {
            if !LoginManager.shared.isLoggedIn() {
                self.selectedIndex = currentIndex
            }
        }
        
        
        if selectedIndex == Tabs.hub.rawValue {
            if !LoginManager.shared.isLoggedIn() {
                self.selectedIndex = currentIndex
            }
        }
        
        
        
        
//        if selectedIndex == Tabs.launch.rawValue {
//            self.campusClubsVC.sortClubInfoArray()
//            self.campusClubsVC.collectionView.reloadData()
//            self.campusClubsVC.collectionView.scrollToTop(true)
//
//        }
//
//
//        if selectedIndex == Tabs.hub.rawValue {
//            self.categoriesVC.collectionView.scrollToTop(true)
//
//        }
        
    }
    
    
    

}
