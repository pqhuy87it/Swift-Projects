//
//  UICollectionReusableView+Extension.swift
//  Swift-Extension
//
//  Created by HuyPQ22 on 2021/10/11.
//  Copyright © 2021 Huy Pham Quang. All rights reserved.
//

import UIKit

extension UICollectionReusableView {
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

