//
//  SelectTextController.swift
//  Label Example
//
//  Created by HuyPQ22 on 2021/10/12.
//

import UIKit

class SelectTextController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Initialize Tap Gesture Recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapGestureHandle(_:)))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - Actions
    
    @IBAction func didTapGestureHandle(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

extension SelectTextController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.perform(#selector(selectAll(_:)), with: nil, afterDelay: 0.1)
        textField.selectAll(self)
    }
}
