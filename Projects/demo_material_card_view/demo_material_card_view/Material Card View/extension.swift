//
//  extension.swift
//  demo_material_card_view
//
//  Created by huy on 2025/12/27.
//

import Foundation
import UIKit

// MARK: - UIView Frame Extensions
// Thư viện này dùng manual layout (tính toán x, y, width, height) thay vì AutoLayout
extension UIView {
    var x: CGFloat {
        get { return self.frame.origin.x }
        set { self.frame.origin.x = newValue }
    }
    var y: CGFloat {
        get { return self.frame.origin.y }
        set { self.frame.origin.y = newValue }
    }
    var w: CGFloat {
        get { return self.frame.size.width }
        set { self.frame.size.width = newValue }
    }
    var h: CGFloat {
        get { return self.frame.size.height }
        set { self.frame.size.height = newValue }
    }
    
    var bottom: CGFloat {
        get { return self.y + self.h }
    }
    
    func bottomWithOffset(_ offset: CGFloat) -> CGFloat {
        return self.bottom + offset
    }
    
    // Tiện ích thêm Tap Gesture dạng closure
    func addTapGesture(tapNumber: Int = 1, action: ((UITapGestureRecognizer) -> Void)?) {
        let tap = BlockTap(tapCount: tapNumber, fingerCount: 1, action: action)
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
}

// MARK: - Color & Font Helpers
extension UIColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
    static func grayColor(_ gray: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: gray/255.0, green: gray/255.0, blue: gray/255.0, alpha: alpha)
    }
}
