//
//  NSRegularExpression.swift
//  Swift-Utility
//
//  Created by mybkhn on 2020/05/21.
//  Copyright © 2020 Pham Quang Huy. All rights reserved.
//

import Foundation

func matches(for regex: String, in text: String) -> [String] {

	do {
		let regex = try NSRegularExpression(pattern: regex)
		let results = regex.matches(in: text,
									range: NSRange(text.startIndex..., in: text))
		return results.map {
			String(text[Range($0.range, in: text)!])
		}
	} catch let error {
		print("invalid regex: \(error.localizedDescription)")
		return []
	}
}
