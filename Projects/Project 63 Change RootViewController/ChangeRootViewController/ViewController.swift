//
//  ViewController.swift
//  ChangeRootViewController
//
//  Created by huy on 2023/10/07.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeRootViewControllerDidTap(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.changeRootViewController()
    }
    
}

