//
//  MultiLanguageLabel.swift
//  LanguageViewController
//
//  Created by Pham Quang Huy on 1/30/18.
//  Copyright © 2018 Pham Quang Huy. All rights reserved.
//

import Foundation
import UIKit

class MultiLanguageLabel: UILabel, LocalizeSupportType {
    var language: Language = .japanese {
        didSet {
            let _ = intrinsicContentSize
        }
    }
    
    override var text: String? {
        didSet {
            if let text = text {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = self.textAlignment
                paragraphStyle.lineBreakMode = self.lineBreakMode
                paragraphStyle.minimumLineHeight = self.font.pointSize + 6
                paragraphStyle.maximumLineHeight = self.font.pointSize + 6
                let attributedText = NSMutableAttributedString(string: text)
                attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
                self.attributedText = attributedText
            }
            
            layoutIfNeeded()
        }
    }
    
    let padding = UIEdgeInsets(top: 2, left: 2, bottom: 5, right: 2)
    
    override func drawText(in rect: CGRect) {
        let newRect = rect.inset(by: padding)
        super.drawText(in: newRect)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override var intrinsicContentSize : CGSize {
        var intrinsicContentSize = super.intrinsicContentSize
        intrinsicContentSize.height += padding.top + padding.bottom
        intrinsicContentSize.width += padding.left + padding.right
        return intrinsicContentSize
    }
}
