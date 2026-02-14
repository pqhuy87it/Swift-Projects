//
//  PTCardTabBar.swift
//  demo_card_tab_bar
//
//  Created by huy on 2025/12/27.
//

import Foundation
import UIKit

// Model đơn giản để chứa dữ liệu icon/title
struct PTTabBarItemModel {
    let image: UIImage?
    let title: String?
}

class PTCardTabBar: UIView {
    
    // Callback khi user tap vào tab
    var didSelectTab: ((Int) -> Void)?
    
    private var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .center
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private var buttons: [UIButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDesign()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDesign()
    }
    
    private func setupDesign() {
        backgroundColor = .white // Màu nền của Card
        
        // Bo góc tròn
        layer.cornerRadius = 20
        
        // Đổ bóng (Shadow) tạo hiệu ứng nổi
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 8
        
        // Add StackView chứa các nút
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    func setItems(_ items: [PTTabBarItemModel]) {
        // Xóa cũ
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        
        // Tạo nút mới
        for (index, item) in items.enumerated() {
            let button = UIButton()
            button.setImage(item.image?.withRenderingMode(.alwaysTemplate), for: .normal)
            button.tintColor = (index == 0) ? .systemPink : .lightGray // Màu mặc định cho tab đầu tiên
            button.tag = index
            button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
    }
    
    @objc private func tabButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        
        // Animation đổi màu đơn giản
        buttons.forEach { $0.tintColor = .lightGray }
        sender.tintColor = .systemPink // Màu active
        
        didSelectTab?(index)
    }
}
