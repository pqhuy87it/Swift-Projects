//
//  Utility.swift
//  DisplayFurigana
//
//  Created by Huy Pham Quang on 1/3/20.
//  Copyright © 2020 Huy Pham Quang. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func find(pattern: String) -> NSTextCheckingResult? {
        do {
            let re = try NSRegularExpression(pattern: pattern, options: [])
            return re.firstMatch(
                in: self,
                options: [],
                range: NSMakeRange(0, self.utf16.count))
        } catch {
            return nil
        }
    }

    func replace(pattern: String, template: String) -> String {
        do {
            let re = try NSRegularExpression(pattern: pattern, options: [])
            return re.stringByReplacingMatches(
                in: self,
                options: [],
                range: NSMakeRange(0, self.utf16.count),
                withTemplate: template)
        } catch {
            return self
        }
    }
}



class Utility: NSObject {
    class var sharedInstance: Utility {
        struct Singleton {
            static let instance = Utility()
        }
        return Singleton.instance
    }

    func furigana(String:String) -> NSMutableAttributedString {
        let attributed =
            String
                .replace(pattern: "(｜.+?＜.+?＞)", template: ",$1,")
                .components(separatedBy: ",")
                .map { x -> NSAttributedString in
                    if let pair = x.find(pattern: "｜(.+?)＜(.+?)＞") {
                        let string = (x as NSString).substring(with: pair.range(at: 1))
                        let ruby = (x as NSString).substring(with: pair.range(at: 2))

                        var text: [Unmanaged<CFString>?] = [Unmanaged<CFString>.passRetained(ruby as CFString) as Unmanaged<CFString>, .none, .none, .none]
                        let annotation = CTRubyAnnotationCreate(CTRubyAlignment.auto, CTRubyOverhang.auto, 0.5, &text[0])

                        return NSAttributedString(
                            string: string,
                            attributes: [kCTRubyAnnotationAttributeName as NSAttributedString.Key: annotation])
                    } else {
                        return NSAttributedString(string: x, attributes: nil)
                    }
                }
                .reduce(NSMutableAttributedString()) { $0.append($1); return $0 }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.5
        paragraphStyle.lineSpacing = 12
		attributed.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSMakeRange(10, 3))
		attributed.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(10, 3))
        attributed.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, (attributed.length)))
        attributed.addAttributes([NSAttributedString.Key.font: UIFont(name: "HiraMinProN-W3", size: 14.0)!, NSAttributedString.Key.verticalGlyphForm: false,],range: NSMakeRange(0, (attributed.length)))

        return attributed
    }

}
