//
//  MainViewController.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/02/25.
//

import UIKit
import Then

final class MainViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTabBar()
        self.setupViewControllers()
    }
    
    private func setupTabBar() {
        self.tabBar.do {
            $0.barStyle = .default
            $0.isTranslucent = false
            $0.tintColor = .customWhtie // 색 수정
            $0.unselectedItemTintColor = .gray02 // 색 수정
            $0.backgroundColor = .gray06 // 색 수정
        }
    }
    private func setupViewControllers() {
        let viewControllers = [
            self.homeViewController,
            self.shareViewController,
            self.settingsViewController
        ]
        
        self.setViewControllers(viewControllers, animated: false)
    }
    
    private var homeViewController: UINavigationController = {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel).then {
            $0.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "icn-home"), selectedImage: nil)
        }
        return UINavigationController(rootViewController: viewController).then {
            $0.setNavigationBarHidden(true, animated: false)
        }
    }()
    
    private var shareViewController: UINavigationController = {
        let viewModel = ShareViewModel()
        let viewController = ShareViewController(viewModel: viewModel).then {
            $0.tabBarItem = UITabBarItem(title: "Share", image: UIImage(named: "icn-share"), selectedImage: nil)
        }
        return UINavigationController(rootViewController: viewController).then {
            $0.setNavigationBarHidden(true, animated: false)
        }
    }()
    
    private var settingsViewController: UINavigationController = {
        let viewModel = SettingsViewModel()
        let viewController = SettingsViewController(viewModel: viewModel).then {
            $0.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "icn-settings"), selectedImage: nil)
        }
        return UINavigationController(rootViewController: viewController).then {
            $0.setNavigationBarHidden(true, animated: false)
        }
    }()
    
}
