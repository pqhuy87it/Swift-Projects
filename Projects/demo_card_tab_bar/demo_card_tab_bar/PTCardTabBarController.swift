//
//  PTCardTabBarController.swift
//  demo_card_tab_bar
//
//  Created by huy on 2025/12/27.
//

import Foundation
import UIKit

open class PTCardTabBarController: UITabBarController {
    
    // UI Elements
    let customTabBarView = PTCardTabBar()
    
    // Config
    fileprivate let tabBarHeight: CGFloat = 60 // Chiều cao của TabBar
    fileprivate let horizontalMargin: CGFloat = 20 // Khoảng cách 2 bên lề
    fileprivate let bottomMargin: CGFloat = 30 // Khoảng cách với đáy màn hình
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        // 1. Ẩn TabBar mặc định
        self.tabBar.isHidden = true
        
        // 2. Thêm Custom TabBar
        view.addSubview(customTabBarView)
        customTabBarView.translatesAutoresizingMaskIntoConstraints = false
        
        // 3. Setup Constraints (Neo nó lơ lửng ở dưới)
        NSLayoutConstraint.activate([
            customTabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            customTabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),
            customTabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -bottomMargin),
            customTabBarView.heightAnchor.constraint(equalToConstant: tabBarHeight)
        ])
        
        // 4. Handle sự kiện chọn tab
        customTabBarView.didSelectTab = { [weak self] index in
            self?.selectedIndex = index
        }
    }
    
    // Cập nhật lại các items khi set viewControllers
    override open func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        guard let vcs = viewControllers else { return }
        // Lấy icon và title từ các ViewController con
        let items = vcs.map { PTTabBarItemModel(image: $0.tabBarItem.image, title: $0.tabBarItem.title) }
        customTabBarView.setItems(items)
    }
}
