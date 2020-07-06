//
//  ObjectComposer.swift
//  SVGExample
//
//  Created by mybkhn on 2020/06/26.
//  Copyright © 2020 exlinct. All rights reserved.
//

import Foundation
import UIKit

typealias KanjiNumberPosition = (x: String, y: String)

class KanjiComposer: NSObject {
	let pathHTMLTemplate = Bundle.main.path(forResource: "template", ofType: "html")
	let pathKanjiStokeTemplate = Bundle.main.path(forResource: "kanjiStroke", ofType: "html")
    let pathKanjiNumberTemplate = Bundle.main.path(forResource: "kanjiNumber", ofType: "html")

	override init() {
		super.init()
	}

    func render(_ colors: [String], paths: [String], positions: [KanjiNumberPosition]) -> String? {
		do {
			var HTMLContent = try String(contentsOfFile: pathHTMLTemplate!)

			// The items will be added by using a loop.
            var allItems = ""

			for (i, path) in paths.enumerated() {
				var kanjiStrokeContent: String!
                var kanjiNumberContent: String!

				kanjiStrokeContent = try String(contentsOfFile: pathKanjiStokeTemplate!)
                kanjiNumberContent = try String(contentsOfFile: pathKanjiNumberTemplate!)

				// Replace color
				kanjiStrokeContent = kanjiStrokeContent.replacingOccurrences(of: "#COLOR#", with: colors[i])

				// Replace path
				kanjiStrokeContent = kanjiStrokeContent.replacingOccurrences(of: "#PATH#", with: path)
                
                // Replace pos x
                kanjiNumberContent = kanjiNumberContent.replacingOccurrences(of: "#POSX#", with: "\(positions[i].x)")
                
                // Replace pos y
                kanjiNumberContent = kanjiNumberContent.replacingOccurrences(of: "#POSY#", with: "\(positions[i].y)")
                
                // Replace number
                kanjiNumberContent = kanjiNumberContent.replacingOccurrences(of: "#NUMBER#", with: "\(i)")
                
                // Replace color
                kanjiNumberContent = kanjiNumberContent.replacingOccurrences(of: "#COLOR#", with: colors[i])

                // Add the item's HTML code to the general items string.
                allItems += kanjiStrokeContent + kanjiNumberContent
			}

			// Set the items.
			HTMLContent = HTMLContent.replacingOccurrences(of: "#ITEMS#", with: allItems)

			// The HTML code is ready.
			return HTMLContent

		} catch {
			print("Unable to open and use HTML template files.")
		}

		return nil
	}
}
