//
//  UICollectionViewCell+Extension.swift
//  Swift-Extension
//
//  Created by HuyPQ22 on 2021/10/11.
//  Copyright © 2021 Huy Pham Quang. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    class var identifier: String {
        return String(describing: self)
    }
}
