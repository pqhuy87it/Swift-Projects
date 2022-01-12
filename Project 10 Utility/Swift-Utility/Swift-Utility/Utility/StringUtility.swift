//
//  StringUtility.swift
//  Swift-Utility
//
//  Created by mybkhn on 2020/05/21.
//  Copyright © 2020 Pham Quang Huy. All rights reserved.
//

import Foundation

func randomString(length: Int) -> String {
	let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	return String((0..<length).map{ _ in letters.randomElement()! })
}
