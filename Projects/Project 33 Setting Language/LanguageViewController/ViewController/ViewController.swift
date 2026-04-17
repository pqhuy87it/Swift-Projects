//
//  ViewController.swift
//  LanguageViewController
//
//  Created by Pham Quang Huy on 1/30/18.
//  Copyright © 2018 Pham Quang Huy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LocalizeSupportType {

    @IBOutlet weak var label1: MultiLanguageLabel!
    @IBOutlet weak var label2: MultiLanguageLabel!
    @IBOutlet weak var label3: MultiLanguageLabel!
    @IBOutlet weak var label4: MultiLanguageLabel!
    
    var language: Language = .japanese {
        didSet {
            label1.text = "Good morning".localize()
            label2.text = "Good afternoon".localize()
            label3.text = "Good evening".localize()
            label4.text = "Goodbye".localize()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        beginLocalizing()
    }

    // Mark: IBActions
    @IBAction func btnSettingPressed(_ sender: Any) {
        if let naviLanguageConfigViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationControllerLanguageConfigViewController") as? UINavigationController {
            self.present(naviLanguageConfigViewController, animated: true, completion: nil)
        }
    }
    
}

