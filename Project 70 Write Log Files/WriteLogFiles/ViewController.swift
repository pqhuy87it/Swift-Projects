//
//  ViewController.swift
//  WriteLogFiles
//
//  Created by huy on 2025/02/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        LogHandler.log(message: "Hi")
        LogHandler.log(message: "Hello", event: .i)
    }


}

