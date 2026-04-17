//
//  UIColorExt.swift
//  LanguageViewController
//
//  Created by Pham Quang Huy on 1/31/18.
//  Copyright © 2018 Pham Quang Huy. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(rgb255 red: CGFloat, _ green: CGFloat, _ blue: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    class func hexStringToUIColor(_ hexStr: NSString, alpha: CGFloat) -> UIColor {
        let hexStr = hexStr.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexStr)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r, green:g ,blue:b ,alpha:alpha)
        } else {
            return UIColor.white
        }
    }
}
