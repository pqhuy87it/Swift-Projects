//
//  ConfigContentBaseViewController.swift
//  LanguageViewController
//
//  Created by Pham Quang Huy on 1/30/18.
//  Copyright © 2018 Pham Quang Huy. All rights reserved.
//

import UIKit

protocol ConfigContentType {
    /// 絶対に初期化後すぐに入れること！！
//    weak var coordinator: ConfigViewCoordinatorType! { get set }
    
    var topNavigationBarShown: Bool { get }  // default = true
    var subNavigationBarShown: Bool { get }  // default = true
    var subNavigationBarTitle: String { get }
    var subNavigationBarColor: UIColor { get }  // default = category.color()
    var backButtonShown: Bool { get }        // default = true
}

class ConfigContentBaseViewController: UIViewController, ConfigContentType {

    enum ConfigContentCategory {
        case sevenBank
        case nanaco
        case common
        case userPolicy
        
        // 基本的に内容によって色が決められている (時期もありました。。)
        func barBackgroundColor() -> UIColor {
            switch self {
            case .sevenBank:
                return UIColor.white
            case .nanaco:
                return UIColor.white
            case .common:
                return UIColor.white
            case .userPolicy:
                return UIColor.white
            }
        }
        
        func barTextColor() -> UIColor {
            switch self {
            case .sevenBank:
                return UIColor.white
            case .nanaco:
                return UIColor.white
            case .common:
                return UIColor.white
            case .userPolicy:
                return UIColor.black
            }
        }
    }
    
    var category: ConfigContentCategory { return .common }
    
    var topNavigationBarShown: Bool { return true }
    var subNavigationBarShown: Bool { return true }
    var subNavigationBarTitle: String { return "" }
    var subNavigationBarColor: UIColor { return category.barBackgroundColor() }
    var subNavigationBarTextColor: UIColor { return category.barTextColor() }
    var backButtonShown: Bool { return true }
    
    // 応急処置
    var backButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
}
