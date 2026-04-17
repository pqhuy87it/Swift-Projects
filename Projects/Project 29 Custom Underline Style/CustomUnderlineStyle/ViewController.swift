//
//  ViewController.swift
//  CustomUnderlineStyle
//
//  Created by mybkhn on 2020/08/21.
//  Copyright © 2020 exlinct. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		let storage = NSTextStorage()
		let layout = UnderlineLayout()
		storage.addLayoutManager(layout)
		let container = NSTextContainer()
		container.widthTracksTextView = true
		container.lineFragmentPadding = 0
		container.maximumNumberOfLines = 2
		container.lineBreakMode = .byTruncatingTail
		layout.addTextContainer(container)

		let textView = UITextView(frame: CGRect(x: 100, y: 100, width: UIScreen.main.bounds.width-40, height: 50), textContainer: container)
		textView.isUserInteractionEnabled = true
		textView.isEditable = false
		textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		textView.text = "1sadasdasdasdasdsadasdfdsf"
		textView.backgroundColor = UIColor.white

		let rg = NSString(string: textView.text!).range(of: textView.text!)
		let attributes = [NSAttributedString.Key.underlineStyle.rawValue: 0x11,
						  NSAttributedString.Key.underlineColor: UIColor.blue.withAlphaComponent(0.2),
						  NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
						  NSAttributedString.Key.baselineOffset:3] as! [NSAttributedString.Key : Any]

		storage.addAttributes(attributes, range: rg)
		view.addSubview(textView)
	}


}

class UnderlineLayout: NSLayoutManager {
	override func drawUnderline(forGlyphRange glyphRange: NSRange, underlineType underlineVal: NSUnderlineStyle, baselineOffset: CGFloat, lineFragmentRect lineRect: CGRect, lineFragmentGlyphRange lineGlyphRange: NSRange, containerOrigin: CGPoint) {
		if let container = textContainer(forGlyphAt: glyphRange.location, effectiveRange: nil) {
			let boundingRect = self.boundingRect(forGlyphRange: glyphRange, in: container)
			let offsetRect = boundingRect.offsetBy(dx: containerOrigin.x, dy: containerOrigin.y)

			let left = offsetRect.minX
			let bottom = offsetRect.maxY
			let width = offsetRect.width
			let path = UIBezierPath()
			path.lineWidth = 3
			path.move(to: CGPoint(x: left, y: bottom))
			path.addLine(to: CGPoint(x: left + width, y: bottom))
			path.stroke()
		}
	}
}
