//
//  UIColor+Extensions.swift
//  CollapseExpandSections
//
//  Created by huy on 2023/07/22.
//

import Foundation
import UIKit

let colours = [UIColor.kdBrown, UIColor.kdGreen, UIColor.kdBlue]

extension UIColor {
    static var kdBrown:UIColor {
        return UIColor(red: 177.0/255.0, green: 88.0/255.0, blue: 39.0/255.0, alpha: 1.0)
    }
    static var kdGreen:UIColor {
        return UIColor(red: 138.0/255.0, green: 149.0/255.0, blue: 86.0/255.0, alpha: 1.0)
    }
    static var kdBlue:UIColor {
        return UIColor(red: 53.0/255.0, green: 102.0/255.0, blue: 149.0/255.0, alpha: 1.0)
    }
}
