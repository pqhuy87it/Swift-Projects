//
//  UINavigationBar-Utility.swift
//  Swift-Utility
//
//  Created by mybkhn on 2020/05/21.
//  Copyright © 2020 Pham Quang Huy. All rights reserved.
//

import Foundation
import UIKit

func changeNavigationBarColor(barTintColor: UIColor, tintColor: UIColor,forgroundColor: UIColor, isTranslucent: Bool){
	UINavigationBar.appearance().barTintColor = barTintColor
	UINavigationBar.appearance().tintColor = tintColor
	UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: forgroundColor]
	UINavigationBar.appearance().isTranslucent = isTranslucent
}
