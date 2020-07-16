//
//  CircleView.swift
//  DrawCircleView
//
//  Created by mybkhn on 2020/07/09.
//  Copyright © 2020 exlinct. All rights reserved.
//

import UIKit

class CircleView: UIView {

	var circleLayer: CAShapeLayer!

	override class func awakeFromNib() {
		super.awakeFromNib()
	}

	required init?(coder: NSCoder) {
		super.init(coder:coder)
		self.setup()
	}

	func setup() {
		self.backgroundColor = UIColor.clear

		// Use UIBezierPath as an easy way to create the CGPath for the layer.
		// The path should be the entire circle.
		let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0,
														 y: frame.size.height / 2.0),
									  radius: (frame.size.width - 10)/2,
									  startAngle: CGFloat(-Double.pi/2),
									  endAngle:  CGFloat(Double.pi * 1.5),
									  clockwise: true)

		// Setup the CAShapeLayer with the path, colors, and line width
		circleLayer = CAShapeLayer()
		circleLayer.path = circlePath.cgPath
		circleLayer.fillColor = UIColor.clear.cgColor
		circleLayer.strokeColor = UIColor.red.cgColor
		circleLayer.lineWidth = 5.0;

		// Don't draw the circle initially
		circleLayer.strokeEnd = 0.0

		// Add the circleLayer to the view's layer's sublayers
		layer.addSublayer(circleLayer)
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	func animateCircle(duration: TimeInterval) {
		// We want to animate the strokeEnd property of the circleLayer
		let animation = CABasicAnimation(keyPath: "strokeEnd")

		// Set the animation duration appropriately
		animation.duration = duration

		// Animate from 0 (no circle) to 1 (full circle)
		animation.fromValue = 0
		animation.toValue = 1

		// Do a linear animation (i.e. the speed of the animation stays the same)
		animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)

		// Set the circleLayer's strokeEnd property to 1.0 now so that it's the
		// right value when the animation ends.
		circleLayer.strokeEnd = 1.0

		circleLayer.lineCap = .round

		// Do the actual animation
		circleLayer.add(animation, forKey: "animateCircle")
	}

}
