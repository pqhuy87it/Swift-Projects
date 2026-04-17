//
//  ViewController.swift
//  SVGExample
//
//  Created by mybkhn on 2020/06/25.
//  Copyright © 2020 exlinct. All rights reserved.
//

import UIKit
import Macaw
import SWXMLHash
import WebKit

class ViewController: UIViewController {

	private var wkWebView: WKWebView!
    private var pathArray: [String] = []
	private var valueArray: [String] = []
	private var transformArray: [String] = []

	var arrColors: [UIColor] = [.red, .blue, .yellow, .magenta, .cyan, .green, .orange, .purple, .brown, .gray, .systemPink, .black]

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

        self.setupUI()
		self.parseSVG()
        self.createHTML()
	}

	func setupUI() {
		self.setupWebView()
	}

	func setupWebView() {
		let webConfig = WKWebViewConfiguration()
		wkWebView = WKWebView(frame: .zero, configuration: webConfig)
		wkWebView.translatesAutoresizingMaskIntoConstraints = false

		self.view.insertSubview(wkWebView, at: 0)

		NSLayoutConstraint(item: wkWebView!,
						   attribute: .leading,
						   relatedBy: .equal,
						   toItem: self.view,
						   attribute: .leading,
						   multiplier: 1.0,
						   constant: 0).isActive = true
		NSLayoutConstraint(item: wkWebView!,
						   attribute: .trailing,
						   relatedBy: .equal,
						   toItem: self.view,
						   attribute: .trailing,
						   multiplier: 1.0,
						   constant: 0).isActive = true
		NSLayoutConstraint(item: wkWebView!,
						   attribute: .top,
						   relatedBy: .equal,
						   toItem: self.view,
						   attribute: .top,
						   multiplier: 1.0,
						   constant: 0).isActive = true
		NSLayoutConstraint(item: wkWebView!,
						   attribute: .bottom,
						   relatedBy: .equal,
						   toItem: self.view,
						   attribute: .bottom,
						   multiplier: 1.0,
						   constant: 0).isActive = true
	}

	func parseSVG() {
		if let url = Bundle.main.url(forResource: "05c04", withExtension: "svg") {
			if let xmlString = try? String(contentsOf: url) {
				let xml = SWXMLHash.parse(xmlString)
				enumerate(indexer: xml, level: 0)
			}
		}
	}

	private func enumerate(indexer: XMLIndexer, level: Int) {
		for child in indexer.children {
			if let element = child.element {
				if let idAttribute = element.attribute(by: "id") {
					let text = idAttribute.text
					pathArray.append(text)
				}

				if let value = element.attribute(by: "d") {
					let text = value.text
					valueArray.append(text)
				}

				if let transform = element.attribute(by: "transform") {
					let text = transform.text
					transformArray.append(text)
				}
			}

			enumerate(indexer: child, level: level + 1)
		}
	}

	func createHTML() {
		let composer = KanjiComposer()
		let colors = self.arrColors.map{ $0.toHexString() }

        if let htmlStr = composer.render(colors, paths: self.valueArray, positions: self.formatListPosition()) {
			self.wkWebView.loadHTMLString("<html>\n<body>\n    <div _ngcontent-c30=\"\" id=\"image-holder-射\">\n        <svg height=\"600px\" version=\"1.1\" width=\"600px\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" style=\"overflow: hidden; position: relative; left: -0.25px; top: -0.5px;\" viewBox=\"0 0 100 100\" preserveAspectRatio=\"xMinYMin\" class=\"dmak-svg\">\n                <desc style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0);\">Created with Raphaël 2.1.2</desc>\n                <defs style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0);\"></defs>\n                <!-- Thanh dash doc -->\n                <path fill=\"none\" stroke=#cccccc d=\"M62.5,0L62.5,125\" stroke-width=\"0.5\" stroke-dasharray=\"4,1.5\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0);\"></path>\n                <!-- Thanh dash ngang -->\n                <path fill=\"none\" stroke=\"#cccccc\" d=\"M0,62.5L125,62.5\" stroke-width=\"0.5\" stroke-dasharray=\"4,1.5\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0);\"></path>\n                <path fill=\"none\" stroke=\"#FF0000\" d=\"M31.18,13.51c0.97,0.97,1.62,2.28,1.62,3.71c0,1.44,0.01,4.82,0.01,8.72\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); stroke-linecap: round; stroke-linejoin: round; transition: stroke 400ms ease 0s; stroke-dashoffset: 0;\" stroke-width=\"3\" stroke-linecap=\"round\" stroke-linejoin=\"round\"></path><text x=\"26.25\" y=\"10.63\" text-anchor=\"middle\" font-family=\"&quot;Arial&quot;\" font-size=\"8px\" stroke=\"none\" fill=\"#FF0000\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: middle; font-family: Arial; font-size: 8px;\"><tspan dy=\"2.75\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0);\">0</tspan></text><path fill=\"none\" stroke=\"#0000FF\" d=\"M16.82,29.19c1.12,0.11,2.45,0.15,3.55,0.03C25.75,28.62,36,26.62,42.39,26c1.86-0.18,3.24-0.25,4.27,0.02\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); stroke-linecap: round; stroke-linejoin: round; transition: stroke 400ms ease 0s; stroke-dashoffset: 0;\" stroke-width=\"3\" stroke-linecap=\"round\" stroke-linejoin=\"round\"></path><text x=\"9.75\" y=\"27.13\" text-anchor=\"middle\" font-family=\"&quot;Arial&quot;\" font-size=\"8px\" stroke=\"none\" fill=\"#0000FF\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: middle; font-family: Arial; font-size: 8px;\"><tspan dy=\"2.75\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0);\">1</tspan></text><path fill=\"none\" stroke=\"#0000A0\" d=\"M21.81,33.25c2.44,3.38,4.02,7.74,4.35,10.98\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); stroke-linecap: round; stroke-linejoin: round; transition: stroke 400ms ease 0s; stroke-dashoffset: 0;\" stroke-width=\"3\" stroke-linecap=\"round\" stroke-linejoin=\"round\"></path><text x=\"15.75\" y=\"39.13\" text-anchor=\"middle\" font-family=\"&quot;Arial&quot;\" font-size=\"8px\" stroke=\"none\" fill=\"#0000A0\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: middle; font-family: Arial; font-size: 8px;\"><tspan dy=\"2.75\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0);\">2</tspan></text><path fill=\"none\" stroke=\"#800080\" d=\"M40.93,30.75c0.25,0.67,0.28,1.87,0.11,2.58c-0.4,3.04-2.04,7.79-2.42,9.67\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); stroke-linecap: round; stroke-linejoin: round; transition: stroke 400ms ease 0s; stroke-dashoffset: 0;\" stroke-width=\"3\" stroke-linecap=\"round\" stroke-linejoin=\"round\"></path><text x=\"33.75\" y=\"36.13\" text-anchor=\"middle\" font-family=\"&quot;Arial&quot;\" font-size=\"8px\" stroke=\"none\" fill=\"#800080\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: middle; font-family: Arial; font-size: 8px;\"><tspan dy=\"2.75\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0);\">3</tspan></text><path fill=\"none\" stroke=\"#00FF00\" d=\"M12.92,48.45c2.08,0.3,3.29,0.33,5.54,0.03c7.29-0.98,21.04-3.98,28.37-4.49c1.43-0.1,3.45-0.04,4.17,0.01\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); stroke-linecap: round; stroke-linejoin: round; transition: stroke 400ms ease 0s; stroke-dashoffset: 0;\" stroke-width=\"3\" stroke-linecap=\"round\" stroke-linejoin=\"round\"></path><text x=\"5.25\" y=\"51.13\" text-anchor=\"middle\" font-family=\"&quot;Arial&quot;\" font-size=\"8px\" stroke=\"none\" fill=\"#00FF00\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: middle; font-family: Arial; font-size: 8px;\"><tspan dy=\"2.75\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0);\">4</tspan></text><path fill=\"none\" stroke=\"#FF00FF\" d=\"M13.76,62.95c0.77,0.23,2.48,0.59,4.5,0.34c7.37-0.91,18.57-3.05,26.1-4.48c2.01-0.38,3.14-0.3,4.14-0.3\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); stroke-linecap: round; stroke-linejoin: round; transition: stroke 400ms ease 0s; stroke-dashoffset: 0;\" stroke-width=\"3\" stroke-linecap=\"round\" stroke-linejoin=\"round\"></path><text x=\"5.25\" y=\"66.13\" text-anchor=\"middle\" font-family=\"&quot;Arial&quot;\" font-size=\"8px\" stroke=\"none\" fill=\"#FF00FF\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: middle; font-family: Arial; font-size: 8px;\"><tspan dy=\"2.75\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0);\">5</tspan></text><path fill=\"none\" stroke=\"#FFA500\" d=\"M32.75,51c1,1,1.53,2.5,1.53,3.93c0,3.82,0.1,26.35-0.11,37.82c-0.04,2.16-0.08,3.83-0.12,4.75\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); stroke-linecap: round; stroke-linejoin: round; transition: stroke 400ms ease 0s; stroke-dashoffset: 0;\" stroke-width=\"3\" stroke-linecap=\"round\" stroke-linejoin=\"round\"></path><text x=\"24.75\" y=\"58.63\" text-anchor=\"middle\" font-family=\"&quot;Arial&quot;\" font-size=\"8px\" stroke=\"none\" fill=\"#FFA500\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: middle; font-family: Arial; font-size: 8px;\"><tspan dy=\"2.75\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0);\">6</tspan></text><path fill=\"none\" stroke=\"#A52A2A\" d=\"M32.12,62.38c0,0.96-0.56,2.17-0.89,2.8c-4.2,8.16-12.56,17.69-19.74,22.07\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); stroke-linecap: round; stroke-linejoin: round; transition: stroke 400ms ease 0s; stroke-dashoffset: 0;\" stroke-width=\"3\" stroke-linecap=\"round\" stroke-linejoin=\"round\"></path><text x=\"17.25\" y=\"75.13\" text-anchor=\"middle\" font-family=\"&quot;Arial&quot;\" font-size=\"8px\" stroke=\"none\" fill=\"#A52A2A\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: middle; font-family: Arial; font-size: 8px;\"><tspan dy=\"2.75\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0);\">7</tspan></text><path fill=\"none\" stroke=\"#008000\" d=\"M37.5,66.75c3.72,2.83,6.11,5.67,8.25,8.5\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); stroke-linecap: round; stroke-linejoin: round; transition: stroke 400ms ease 0s; stroke-dashoffset: 0;\" stroke-width=\"3\" stroke-linecap=\"round\" stroke-linejoin=\"round\"></path><text x=\"44.25\" y=\"69.13\" text-anchor=\"middle\" font-family=\"&quot;Arial&quot;\" font-size=\"8px\" stroke=\"none\" fill=\"#008000\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: middle; font-family: Arial; font-size: 8px;\"><tspan dy=\"2.75\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0);\">8</tspan></text><path fill=\"none\" stroke=\"#808000\" d=\"M55.94,18.69c0.75,0.75,1.34,2.08,1.34,3.48c0,1.14-0.1,27.03-0.05,37.57c0.01,2.41,0.03,3.99,0.05,4.25\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); stroke-linecap: round; stroke-linejoin: round; transition: stroke 400ms ease 0s; stroke-dashoffset: 0;\" stroke-width=\"3\" stroke-linecap=\"round\" stroke-linejoin=\"round\"></path><text x=\"44.25\" y=\"22.63\" text-anchor=\"middle\" font-family=\"&quot;Arial&quot;\" font-size=\"8px\" stroke=\"none\" fill=\"#808000\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: middle; font-family: Arial; font-size: 8px;\"><tspan dy=\"2.75\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0);\">9</tspan></text><path fill=\"none\" stroke=\"#2554C7\" d=\"M58.01,19.83c6.48-0.97,21.25-3.17,23.02-3.33c1.91-0.18,3.76,1.26,3.76,3.03c0,1.35-0.15,28.68-0.32,39.48c-0.04,2.5-0.07,4.11-0.07,4.31\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); stroke-linecap: round; stroke-linejoin: round; transition: stroke 400ms ease 0s; stroke-dashoffset: 0;\" stroke-width=\"3\" stroke-linecap=\"round\" stroke-linejoin=\"round\"></path><text x=\"59.25\" y=\"15.13\" text-anchor=\"middle\" font-family=\"&quot;Arial&quot;\" font-size=\"8px\" stroke=\"none\" fill=\"#2554C7\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: middle; font-family: Arial; font-size: 8px;\"><tspan dy=\"2.75\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0);\">10</tspan></text><path fill=\"none\" stroke=\"#4EE2EC\" d=\"M58.48,32.92c5.27-0.67,20.14-3.04,25.13-3.35\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); stroke-linecap: round; stroke-linejoin: round; transition: stroke 400ms ease 0s; stroke-dashoffset: 0;\" stroke-width=\"3\" stroke-linecap=\"round\" stroke-linejoin=\"round\"></path><text x=\"63.75\" y=\"28.63\" text-anchor=\"middle\" font-family=\"&quot;Arial&quot;\" font-size=\"8px\" stroke=\"none\" fill=\"#4EE2EC\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: middle; font-family: Arial; font-size: 8px;\"><tspan dy=\"2.75\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0);\">11</tspan></text><path fill=\"none\" stroke=\"#387C44\" d=\"M58.44,47.32c7.94-0.7,17.31-2.07,24.63-2.6\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); stroke-linecap: round; stroke-linejoin: round; transition: stroke 400ms ease 0s; stroke-dashoffset: 0;\" stroke-width=\"3\" stroke-linecap=\"round\" stroke-linejoin=\"round\"></path><text x=\"63.75\" y=\"43.63\" text-anchor=\"middle\" font-family=\"&quot;Arial&quot;\" font-size=\"8px\" stroke=\"none\" fill=\"#387C44\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: middle; font-family: Arial; font-size: 8px;\"><tspan dy=\"2.75\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0);\">12</tspan></text><path fill=\"none\" stroke=\"#EDE275\" d=\"M58.59,61.44c6.04-0.44,17.54-1.81,24.63-2.1\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); stroke-linecap: round; stroke-linejoin: round; transition: stroke 400ms ease 0s; stroke-dashoffset: 0;\" stroke-width=\"3\" stroke-linecap=\"round\" stroke-linejoin=\"round\"></path><text x=\"63.75\" y=\"58.63\" text-anchor=\"middle\" font-family=\"&quot;Arial&quot;\" font-size=\"8px\" stroke=\"none\" fill=\"#EDE275\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: middle; font-family: Arial; font-size: 8px;\"><tspan dy=\"2.75\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0);\">13</tspan></text><path fill=\"none\" stroke=\"#FBB117\" d=\"M64,64.5c0.05,0.75,0.12,1.95-0.11,3.03C62.53,73.91,55.5,87.5,44,96.5\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); stroke-linecap: round; stroke-linejoin: round; transition: stroke 400ms ease 0s; stroke-dashoffset: 0;\" stroke-width=\"3\" stroke-linecap=\"round\" stroke-linejoin=\"round\"></path><text x=\"51.75\" y=\"73.63\" text-anchor=\"middle\" font-family=\"&quot;Arial&quot;\" font-size=\"8px\" stroke=\"none\" fill=\"#FBB117\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: middle; font-family: Arial; font-size: 8px;\"><tspan dy=\"2.75\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0);\">14</tspan></text><path fill=\"none\" stroke=\"#FF7F50\" d=\"M73.36,62.72c0.71,0.71,1.27,1.9,1.3,3.61c0.07,4.77-0.06,12.48-0.06,17.94c0,9.49,1.65,10.87,10.65,10.87c9.75,0,11-0.87,11-8.47\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); stroke-linecap: round; stroke-linejoin: round; transition: stroke 400ms ease 0s; stroke-dashoffset: 0;\" stroke-width=\"3\" stroke-linecap=\"round\" stroke-linejoin=\"round\"></path><text x=\"80.25\" y=\"75.13\" text-anchor=\"middle\" font-family=\"&quot;Arial&quot;\" font-size=\"8px\" stroke=\"none\" fill=\"#FF7F50\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); text-anchor: middle; font-family: Arial; font-size: 8px;\"><tspan dy=\"2.75\" style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0);\">15</tspan></text>\n        </svg>\n    </div>\n</body>\n</html>\n", baseURL: nil)
		}
	}

	func createNumberText(_ index: Int) -> String {
		return ""
	}
    
    func formatListPosition() -> [KanjiNumberPosition] {
        var arrKanjiNumberPosition: [KanjiNumberPosition] = []
        
        for (_, str) in self.transformArray.enumerated() {
            let firstIndex = str.index(of: "(")!
            let secondIndex = str.index(of: ")")!
            let numberStr = str[firstIndex..<secondIndex]
            let arrNumber = numberStr.split(separator: " ")
            let posXStr = String(arrNumber[arrNumber.count - 2])
            let posYStr = String(arrNumber[arrNumber.count - 1])
            let kanjiNumberPosition = (x: posXStr, y: posYStr)
            
            arrKanjiNumberPosition.append(kanjiNumberPosition)
        }
        
        return arrKanjiNumberPosition
    }
}

extension UIColor {
	func toHexString() -> String {
		var r:CGFloat = 0
		var g:CGFloat = 0
		var b:CGFloat = 0
		var a:CGFloat = 0

		getRed(&r, green: &g, blue: &b, alpha: &a)

		let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

		return String(format:"#%06x", rgb)
	}
}

extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        var indices: [Index] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                    indices.append(range.lowerBound)
                    startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                        index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return indices
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                    result.append(range)
                    startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                        index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}
