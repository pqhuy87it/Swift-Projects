//
//  ViewController.swift
//  DisplayFurigana
//
//  Created by Huy Pham Quang on 1/3/20.
//  Copyright © 2020 Huy Pham Quang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var furiganaLabel: CustomLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
//        furiganaLabel.attributedText = Utility.sharedInstance.furigana(String: "｜優勝＜ゆうしょう＞の｜懸＜か＞かった｜試合＜しあい＞。")
		furiganaLabel.attributedText = Utility.sharedInstance.furigana(String: "｜日本＜にほん＞が｜好＜す＞きいだから、｜日本語＜にほんご＞を｜勉強＜べんきょう＞します。")
    }
}

class CustomLabel: UILabel, SimpleVerticalGlyphViewProtocol {
    //override func draw(_ rect: CGRect) { // if not has drawText, use draw UIView etc
    override func drawText(in rect: CGRect) {
        let attributed = NSMutableAttributedString(attributedString: self.attributedText!)
        let isVertical = false // if Vertical Glyph, true.
        attributed.addAttributes([NSAttributedString.Key.verticalGlyphForm: isVertical],
                                 range: NSMakeRange(0, attributed.length))
        drawContext(attributed, textDrawRect: rect, isVertical: isVertical)
    }
}

