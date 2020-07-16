//
//  ViewController.swift
//  DrawCircleView
//
//  Created by mybkhn on 2020/07/09.
//  Copyright © 2020 exlinct. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var circleView: CircleView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		self.addCircleView()
	}

	func addCircleView() {
//		let diceRoll = CGFloat(Int(arc4random_uniform(7))*50)
//		let circleWidth = CGFloat(200)
//		let circleHeight = circleWidth
//
//		// Create a new CircleView
//		let circleView = CircleView(frame: CGRect(x: 100, y: 100, width: circleWidth, height: circleHeight))
//
//		view.addSubview(circleView)

		// Animate the drawing of the circle over the course of 1 second
		circleView.animateCircle(duration: 15.0)
	}
}

