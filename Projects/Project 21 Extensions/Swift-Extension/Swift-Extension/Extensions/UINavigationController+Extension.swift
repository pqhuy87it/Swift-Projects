//
//  UINavigationController+Extension.swift
//  Swift-Extension
//
//  Created by Pham Quang Huy on 2020/05/30.
//  Copyright © 2020 Huy Pham Quang. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        
        view.addSubview(statusBarView)
    }
    
}
