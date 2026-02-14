//
//  MaterialCardCell.swift
//  demo_material_card_view
//
//  Created by huy on 2025/12/27.
//

import Foundation
import UIKit

// MARK: - Configuration
struct MaterialCardAppearance {
    var headerBackgroundColor: UIColor = .rgb(r: 242, g: 242, b: 242)
    var cellBackgroundColor: UIColor = .rgb(r: 249, g: 249, b: 249)
    var borderColor: UIColor = .grayColor(200)
    var titleFont: UIFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
    var titleColor: UIColor = .grayColor(51)
    var textFont: UIFont = UIFont.systemFont(ofSize: 13)
    var textColor: UIColor = .grayColor(144)
    var rippleColor: UIColor = .grayColor(51, alpha: 0.1)
}

// MARK: - Material Card Cell (Một hàng trong Card)
class MaterialCardCell: UIView {
    let itemPadding: CGFloat = 16
    var parentCard: MaterialCardView!
    var bottomLine: UIView?
    
    init(card: MaterialCardView) {
        self.parentCard = card
        super.init(frame: CGRect(x: 0, y: 0, width: card.w, height: 0))
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func addTitle(_ title: String) {
        let label = UILabel(frame: CGRect(x: itemPadding, y: 0, width: parentCard.w - itemPadding*2, height: 0))
        label.text = title
        label.textColor = parentCard.appearance.titleColor
        label.font = parentCard.appearance.titleFont
        label.numberOfLines = 0
        
        // Tính toán chiều cao
        let size = label.sizeThatFits(CGSize(width: label.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.frame.size.height = size.height
        label.y = (self.h > 0) ? self.h : itemPadding // Canh lề trên
        
        addSubview(label)
        self.h += label.h + itemPadding * 2
    }
    
    func addText(_ text: String) {
        let label = UILabel(frame: CGRect(x: itemPadding, y: 0, width: parentCard.w - itemPadding*2, height: 0))
        label.text = text
        label.textColor = parentCard.appearance.textColor
        label.font = parentCard.appearance.textFont
        label.numberOfLines = 0
        
        let size = label.sizeThatFits(CGSize(width: label.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.frame.size.height = size.height
        label.y = (self.h > 0) ? self.h : itemPadding
        
        addSubview(label)
        self.h += label.h + itemPadding * 2
    }
    
    func drawBottomLine() {
        if bottomLine != nil { return }
        bottomLine = UIView(frame: CGRect(x: 0, y: h - 1, width: w, height: 1))
        bottomLine!.backgroundColor = parentCard.appearance.borderColor
        addSubview(bottomLine!)
    }
    
    func removeBottomLine() {
        bottomLine?.removeFromSuperview()
        bottomLine = nil
    }
}
