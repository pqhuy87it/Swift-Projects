//
//  CGRect+extension.swift
//  RoundedView
//
//  Created by Huy Pham Quang on 5/5/20.
//  Copyright © 2020 Huy Pham Quang. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGRect {

    /// Returns the coordinates of a corner of the rectangle
    ///
    /// **Important: Values are assumed to be in UIKit's coordinate system i.e.
    /// with the origin at the top-left**
    func getCorner(_ corner: Corner) -> CGPoint {
        switch corner {
        case .topLeft: return CGPoint(x: minX, y: minY)
        case .topRight: return CGPoint(x: maxX, y: minY)
        case .bottomLeft: return CGPoint(x: minX, y: maxY)
        case .bottomRight:  return CGPoint(x: maxX, y: maxY)
        }
    }

    /// The coordinates of the top left corner of the rectangle in UIKit's
    /// coordinate system
    var topLeft: CGPoint {
        return getCorner(.topLeft)
    }

    /// The coordinates of the top right corner of the rectangle in UIKit's
    /// coordinate system
    var topRight: CGPoint {
        return getCorner(.topRight)
    }

    /// The coordinates of the bottom left corner of the rectangle in UIKit's
    /// coordinate system
    var bottomLeft: CGPoint {
        return getCorner(.bottomLeft)
    }

    /// The coordinates of the bottom right corner of the rectangle in UIKit's
    /// coordinate system
    var bottomRight: CGPoint {
        return getCorner(.bottomRight)
    }

    /// Initializes a rectangle using the coordinate of one of its corners and
    /// its size
    ///
    /// **Important: Values are assumed to be in UIKit's coordinate system i.e.
    /// with the origin at the top-left**
    ///
    /// - Parameters:
    ///   - corner: The corner of the rectangle whose location is known
    ///   - cornerPoint: The coordinate of the aforementioned corner
    ///   - size: The size of the rectangle to be created
    init(withCorner corner: Corner, at cornerLocation: CGPoint, size: CGSize) {

        /// For the left corners, the origin's x-value is the same as that of
        /// the corner. For right corners, the origin's x-value is calculated by
        /// shifting the corner left by the width of the rectangle
        let xOrigin: CGFloat = {
            switch corner {
            case .topLeft, .bottomLeft:
                return cornerLocation.x
            case .topRight, .bottomRight:
                return cornerLocation.x - size.width
            }
        }()

        /// For the top corners, the origin's y-value is the same as that of
        /// the corner. For bottom corners, the origin's y-value is calculated
        /// by shifting the corner up by the height of the rectangle
        let yOrigin: CGFloat = {
            switch corner {
            case .topLeft, .topRight:
                return cornerLocation.y
            case .bottomLeft, .bottomRight:
                return cornerLocation.y - size.height
            }
        }()

        let origin = CGPoint(x: xOrigin, y: yOrigin)

        self.init(origin: origin, size: size)
    }
}
