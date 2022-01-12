//
//  ViewController.swift
//  Swift-Utility
//
//  Created by Pham Quang Huy on 2020/05/21.
//  Copyright © 2020 Pham Quang Huy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//		randomStringUsage()
		testNSRegularExpression()
    }

    func delayUsage() {
        delay(bySeconds: 1.5) {
            // delayed code
        }
        
        delay(bySeconds: 1.5, dispatchLevel: .background) {
            // delayed code that will run on background thread
        }
    }

	func nsRegualrExpressionUsage() {
		let string = "🇩🇪€4€9"
		let matched = matches(for: "[0-9]", in: string)
		print(matched)
	}

	func testNSRegularExpression() {
		let string = "abcdef"
		let matched = matches(for: "^.", in: string)
		print(matched)
	}

	func randomStringUsage() {
		print(randomString(length: 20))
	}

}

