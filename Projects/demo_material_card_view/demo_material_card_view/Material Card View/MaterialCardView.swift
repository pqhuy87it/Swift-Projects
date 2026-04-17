//
//  MaterialCardView.swift
//  demo_material_card_view
//
//  Created by huy on 2025/12/27.
//

import Foundation
import UIKit

// MARK: - Material Card View (Container chính)
class MaterialCardView: UIView {
    
    // Constants
    let cardRadius: CGFloat = 3
    let shadowOpacity: Float = 0.2
    let shadowRadius: CGFloat = 2
    let estimatedRowHeight: CGFloat = 50
    
    var appearance = MaterialCardAppearance()
    var items: [MaterialCardCell] = []
    var contentView: UIView! // Container con để bo góc (cornerRadius)
    
    init(x: CGFloat, y: CGFloat, w: CGFloat) {
        super.init(frame: CGRect(x: x, y: y, width: w, height: 0))
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.backgroundColor = .clear
        
        // Setup Content View (để clip bounds cho nội dung bên trong)
        contentView = UIView(frame: self.bounds)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = cardRadius
        contentView.layer.masksToBounds = true
        addSubview(contentView)
        
        // Setup Shadow cho View cha
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
    }
    
    // Cập nhật lại vị trí các cells
    func updateFrame() {
        var currentY: CGFloat = 0
        for (index, item) in items.enumerated() {
            item.y = currentY
            currentY += item.h
            
            // Logic vẽ đường kẻ ngang
            item.removeBottomLine()
            if index < items.count - 1 {
                item.drawBottomLine()
            }
        }
        
        self.h = currentY
        contentView.h = currentY
    }
    
    // Hàm thêm Header
    func addHeader(_ title: String) {
        let cell = MaterialCardCell(card: self)
        cell.backgroundColor = appearance.headerBackgroundColor
        cell.addTitle(title)
        // Đảm bảo chiều cao tối thiểu
        if cell.h < estimatedRowHeight { cell.h = estimatedRowHeight }
        
        items.insert(cell, at: 0) // Header luôn ở đầu
        contentView.addSubview(cell)
        updateFrame()
    }
    
    // Hàm thêm Cell (Item)
    func addCell(_ text: String, action: (() -> Void)? = nil) {
        let cell = MaterialCardCell(card: self)
        cell.backgroundColor = appearance.cellBackgroundColor
        cell.addText(text)
        if cell.h < estimatedRowHeight { cell.h = estimatedRowHeight }
        
        // Thêm hiệu ứng Ripple khi tap (đơn giản hóa)
        if let action = action {
            cell.addTapGesture { _ in
                // Hiệu ứng nháy nhẹ để giả lập ripple
                UIView.animate(withDuration: 0.1, animations: {
                    cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
                }) { _ in
                    UIView.animate(withDuration: 0.2) {
                        cell.backgroundColor = self.appearance.cellBackgroundColor
                    }
                    action()
                }
            }
        }
        
        items.append(cell)
        contentView.addSubview(cell)
        updateFrame()
    }
}
