//
//  ContainsContentViewController.swift
//  ScrollView
//
//  Created by Pham Quang Huy on 2022/01/01.
//

import UIKit

class ContainsContentViewController: UIViewController {

    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var contentView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews()
    {
        let scrollViewBounds = scrollView.bounds
        let contentViewBounds = contentView.bounds
        
        var scrollViewInsets = UIEdgeInsets.zero
        scrollViewInsets.top = scrollViewBounds.size.height/2.0;
        scrollViewInsets.top -= contentViewBounds.size.height/2.0;
        
        scrollViewInsets.bottom = scrollViewBounds.size.height/2.0
        scrollViewInsets.bottom -= contentViewBounds.size.height/2.0;
        
//        scrollViewInsets.top -= 90
        scrollViewInsets.top -= 91
        
        scrollView.contentInset = scrollViewInsets
    }

}
