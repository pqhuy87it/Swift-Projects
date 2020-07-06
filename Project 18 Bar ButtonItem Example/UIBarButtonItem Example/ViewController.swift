//
//  ViewController.swift
//  UIBarButtonItem Example
//
//  Created by mybkhn on 2020/05/19.
//  Copyright © 2020 exlinct. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		self.navigationItem.rightBarButtonItems = self.alignedBarButtonItems()

		/*
		// barItem
		let leftButton = UIBarButtonItem.createBarButtonItem(position: .left)
		let rightButton = UIBarButtonItem.createBarButtonItem(position: .right)
		self.setNavLeftButton(leftButton)
		self.setNavRightButton(rightButton)
		*/
	}

	func alignedBarButtonItems() -> [UIBarButtonItem] {
		let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
		spacer.width = 8
		let barButton1 = UIBarButtonItem(customView: createCustomButton(offset: spacer.width))
		let barButton2 = UIBarButtonItem(customView: createCustomButton(offset: spacer.width))

		barButton1.customView?.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
		barButton1.customView?.heightAnchor.constraint(equalToConstant: 24.0).isActive = true

		barButton2.customView?.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
		barButton2.customView?.heightAnchor.constraint(equalToConstant: 24.0).isActive = true

		let barButtonsItems = [
			spacer,
			barButton1,
			barButton2,
		]
		return barButtonsItems
	}

	func createCustomButton(offset: CGFloat = 0) -> UIButton {
		let button = CustomButton(frame: CGRect(x:0, y: 0, width: 24, height: 24))
		button.alignmentRectInsetsOverride = UIEdgeInsets(top: 0, left: -offset, bottom: 0, right: offset)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setBackgroundImage(UIImage(named: "icon_circle"), for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		return button
	}
}

class CustomButton: UIButton {
	var alignmentRectInsetsOverride: UIEdgeInsets?

	override var alignmentRectInsets: UIEdgeInsets {
		return alignmentRectInsetsOverride ?? super.alignmentRectInsets
	}
}

class CustomView: UIView {
	var alignmentRectInsetsOverride: UIEdgeInsets?
	override var alignmentRectInsets: UIEdgeInsets {
		return alignmentRectInsetsOverride ?? super.alignmentRectInsets
	}
}

extension UIViewController {

	func setNavLeftButton(_ button: UIBarButtonItem) {
		self.navigationItem.leftBarButtonItems = self.createBarButtonItemsForEachOS(button: button)
	}

	func setNavRightButton(_ button: UIBarButtonItem) {
		self.navigationItem.rightBarButtonItems = self.createBarButtonItemsForEachOS(button: button)
	}

	// iOS11以降の場合はcustom以外のButtonを入れないと外側からの余白が16ptになってしまうので、その対応のために.fixedSpaceを入れている
	// 入れると8ptになる
	private func createBarButtonItemsForEachOS(button: UIBarButtonItem) -> [UIBarButtonItem] {
		if #available(iOS 11, *) {
			return [self.createSpacer(), button]
		} else {
			return [button]
		}
	}

	private func createSpacer() -> UIBarButtonItem {
		let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
		spacer.width = 8 // なんか0にしても8になるので一旦8で
		return spacer
	}
}

extension UIBarButtonItem {

	enum BarButtonItemPosition {
		case right
		case left
	}

	static func createBarButtonItem(position: BarButtonItemPosition) -> UIBarButtonItem {
		let button = CustomButton(frame: CGRect(x:0, y: 0, width: 24, height: 24))
		// spacerが入っている分8pt外側にずらす
		switch position {
		case .left:
			button.alignmentRectInsetsOverride = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
		case .right:
			button.alignmentRectInsetsOverride = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8)
		}
		button.translatesAutoresizingMaskIntoConstraints = false
		return UIBarButtonItem(customView: button)
	}
}
