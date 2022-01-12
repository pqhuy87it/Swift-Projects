//
//  CGRect+Extension.swift
//  Swift-Extension
//
//  Created by mybkhn on 2020/12/08.
//  Copyright © 2020 Huy Pham Quang. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Initializers

public extension CGRect {
    /// SwifterSwift: Create a `CGRect` instance with center and size.
    /// - Parameters:
    ///   - center: center of the new rect.
    ///   - size: size of the new rect.
    init(center: CGPoint, size: CGSize) {
        let origin = CGPoint(x: center.x - size.width / 2.0, y: center.y - size.height / 2.0)
        self.init(origin: origin, size: size)
    }
    
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }

}

extension CGRect {
	
    /// SwifterSwift: Return center of rect.
    var center: CGPoint { CGPoint(x: midX, y: midY) }

	func centeredRectOfSize(_ sz:CGSize) -> CGRect {
		let c = self.center
		let x = c.x - sz.width/2.0
		let y = c.y - sz.height/2.0
		return CGRect(x, y, sz.width, sz.height)
	}
}

// MARK: - Methods

public extension CGRect {
    /// SwifterSwift: Create a new `CGRect` by resizing with specified anchor.
    /// - Parameters:
    ///   - size: new size to be applied.
    ///   - anchor: specified anchor, a point in normalized coordinates -
    ///     '(0, 0)' is the top left corner of rect，'(1, 1)' is the bottom right corner of rect,
    ///     defaults to '(0.5, 0.5)'. Example:
    ///
    ///          anchor = CGPoint(x: 0.0, y: 1.0):
    ///
    ///                       A2------B2
    ///          A----B       |        |
    ///          |    |  -->  |        |
    ///          C----D       C-------D2
    ///
    func resizing(to size: CGSize, anchor: CGPoint = CGPoint(x: 0.5, y: 0.5)) -> CGRect {
        let sizeDelta = CGSize(width: size.width - width, height: size.height - height)
        return CGRect(origin: CGPoint(x: minX - sizeDelta.width * anchor.x,
                                      y: minY - sizeDelta.height * anchor.y),
                      size: size)
    }
}
