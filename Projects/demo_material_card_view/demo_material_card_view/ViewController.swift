//
//  ViewController.swift
//  demo_material_card_view
//
//  Created by huy on 2025/12/27.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .rgb(r: 230, g: 230, b: 230) // Màu nền xám nhẹ cho dễ nhìn Card
        materialDemo()
    }
    
    func materialDemo() {
        let scroll = UIScrollView(frame: view.frame)
        scroll.contentSize = CGSize(width: view.frame.width, height: 1000) // Scrollable area
        view.addSubview(scroll)
        
        let cardWidth = UIScreen.main.bounds.width - 20
        let startY: CGFloat = 40 // Status bar padding giả lập
        
        // --- Card 1 ---
        let c1 = MaterialCardView(x: 10, y: startY, w: cardWidth)
        scroll.addSubview(c1)
        
        c1.addHeader("Header")
        c1.addCell("Item 1") { print("item 1 tapped") }
        c1.addCell("Item 2") { print("item 2 tapped") }
        c1.addCell("Item 3") { print("item 3 tapped") }
        
        // --- Card 2 (Nằm dưới Card 1) ---
        let c2 = MaterialCardView(x: 10, y: c1.bottomWithOffset(15), w: cardWidth)
        scroll.addSubview(c2)
        
        c2.addHeader("Header")
        c2.addCell("Item 1") { print("item 1 tapped") }
        c2.addCell("Item 2") { print("item 2 tapped") }
        c2.addCell("Item 3") { print("item 3 tapped") }
        
        // --- Card 3 (Plain Material Card) ---
        let c3 = MaterialCardView(x: 10, y: c2.bottomWithOffset(15), w: cardWidth)
        scroll.addSubview(c3)
        // Tạo khoảng trắng bằng xuống dòng \n giống trong code gốc của user
        c3.addCell("\n\nPlain Material Card\n\n")
        
        // Cập nhật content size cho scrollview
        scroll.contentSize = CGSize(width: view.frame.width, height: c3.bottomWithOffset(50))
    }
    
    
}

