//
//  ViewController.swift
//  demo_card_tab_bar
//
//  Created by huy on 2025/12/27.
//

import UIKit

class ViewController: PTCardTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Tạo các màn hình con
                let homeVC = UIViewController()
                homeVC.view.backgroundColor = .white
                homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
                
                let searchVC = UIViewController()
                searchVC.view.backgroundColor = .white
                searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
                
                let profileVC = UIViewController()
                profileVC.view.backgroundColor = .white
                profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 2)
                
                // Gán vào controller
                self.viewControllers = [homeVC, searchVC, profileVC]
                
                // Tùy chỉnh màu sắc nếu muốn (Optional)
                self.customTabBarView.backgroundColor = .white
    }


}

