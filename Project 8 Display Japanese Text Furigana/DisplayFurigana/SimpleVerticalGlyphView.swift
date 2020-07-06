//
//  SimpleVerticalGlyphView.swift
//  DisplayFurigana
//
//  Created by Huy Pham Quang on 1/3/20.
//  Copyright © 2020 Huy Pham Quang. All rights reserved.
//

import Foundation
import UIKit

protocol SimpleVerticalGlyphViewProtocol {
}

extension SimpleVerticalGlyphViewProtocol {

    func drawContext(_ attributed:NSMutableAttributedString, textDrawRect:CGRect, isVertical:Bool) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        var path:CGPath
        if isVertical {
            context.rotate(by: .pi / 2)
            context.scaleBy(x: 1.0, y: -1.0)
            path = CGPath(rect: CGRect(x: textDrawRect.origin.y, y: textDrawRect.origin.x, width: textDrawRect.height, height: textDrawRect.width), transform: nil)
        }
        else {
            context.textMatrix = CGAffineTransform.identity
            context.translateBy(x: 0, y: textDrawRect.height)
            context.scaleBy(x: 1.0, y: -1.0)
            path = CGPath(rect: textDrawRect, transform: nil)
        }

        let framesetter = CTFramesetterCreateWithAttributedString(attributed)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attributed.length), path, nil)

        CTFrameDraw(frame, context)
    }
}
