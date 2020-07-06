//
//  ViewController.swift
//  TestPopover
//
//  Created by mybkhn on 2020/01/16.
//  Copyright © 2020 mybkhn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var button: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBAction func buttonDidTap(_ sender: UIButton) {
		let popoverTableViewController = PopoverViewController()
		//		popoverTableViewController.delegate = self
		popoverTableViewController.setupContentOption(optionContent: ["a", "b", "c"], sizeWidthContent: 100, sender: sender)

		popoverTableViewController.modalPresentationStyle = .popover
		popoverTableViewController.popoverPresentationController?.delegate = self
		//			viewController1.view.alpha = 0.0
		//			viewController1.popoverPresentationController?.sourceView?.layer.shadowColor = UIColor.clear.cgColor
		//			viewController1.popoverPresentationController?.containerView?.layer.shadowColor = UIColor.clear.cgColor
		let popover = popoverTableViewController.popoverPresentationController
		popover?.backgroundColor = .clear
		//			popover?.delegate = self
		popover?.sourceView = button
		popover?.permittedArrowDirections = .left
		popover?.popoverLayoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		popover?.sourceRect = CGRect(x: button.frame.width, y: button.frame.height / 2, width: 0, height: 0)
		popoverTableViewController.preferredContentSize = CGSize(width: 50, height: 150)
		present(popoverTableViewController, animated: true, completion: {
			//				popoverTableViewController.popoverPresentationController?.containerView?.backgroundColor = UIColor.white.withAlphaComponent(0.0)
			//				popoverTableViewController.view.layer.shadowColor = UIColor.clear.cgColor
			//				popoverTableViewController.popoverPresentationController?.sourceView?.layer.shadowColor = UIColor.clear.cgColor
			//				popoverTableViewController.popoverPresentationController?.containerView?.layer.shadowColor = UIColor.clear.cgColor
		})

	}
	
	func adaptivePresentationStyle(for controller:UIPresentationController) -> UIModalPresentationStyle {
        print("adaptive was called")
        return .none
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {

}

extension UIPopoverPresentationController {

    var dimmingView: UIView? {
       return value(forKey: "_dimmingView") as? UIView
    }
}

