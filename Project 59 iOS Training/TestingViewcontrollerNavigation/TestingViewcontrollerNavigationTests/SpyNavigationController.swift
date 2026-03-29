//
//  SpyNavigationController.swift
//  TestingViewcontrollerNavigationTests
//
//  Created by Huy Pham on 2024/11/05.
//

import UIKit

class SpyNavigationController: UINavigationController {
    
    var pushedViewcontroller: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        self.pushedViewcontroller = viewController
    }

}
