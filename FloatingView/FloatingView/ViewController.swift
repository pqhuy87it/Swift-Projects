//
//  ViewController.swift
//  FloatingView
//
//  Created by huy on 2023/06/16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnPressed(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let floatingVC = storyBoard.instantiateViewController(withIdentifier: "FloatingViewController") as? FloatingViewController
//        self.present(floatingVC!, animated: true)
        floatingVC?.modalTransitionStyle = .crossDissolve
        floatingVC?.modalPresentationStyle = .overFullScreen
        self.present(floatingVC!, animated: false, completion: nil)
    }
    
}

