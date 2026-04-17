//
//  ViewController.swift
//  Font
//
//  Created by Pham Quang Huy on 2020/12/12.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setup()
    }


    func setup() {
        bgView.layer.cornerRadius = 5.0
        bgView.layer.borderWidth = 1.0
        bgView.layer.borderColor = UIColor.gray.cgColor
        
        let textAttributes1 = [NSAttributedString.Key.font: Font.systemFont(size: 20).value]
        let attributedText1 = NSAttributedString(string: "Demo Text 1",
                                                              attributes: textAttributes1)
        label1.attributedText = attributedText1
        
        let textAttributes2 = [NSAttributedString.Key.font: Font.MPLUS1p(size: 20, weight: .regular).value]
        let attributedText2 = NSAttributedString(string: "Demo Text 2",
                                                              attributes: textAttributes2)
        label2.attributedText = attributedText2
        
        let textAttributes3 = [NSAttributedString.Key.font: Font.hiraMinProN_w6(size: 20).value]
        let attributedText3 = NSAttributedString(string: "Demo Text 3",
                                                              attributes: textAttributes3)
        label3.attributedText = attributedText3
    }
}

