//
//  Header.swift
//  CollectionView
//
//  Created by huy on 2023/06/10.
//

import Foundation
import UIKit

class Header: UICollectionReusableView {
    
    private let label: UILabel!
    
    override init(frame: CGRect) {
        label = UILabel(frame: frame)
        super.init(frame: frame)
        addLabel()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLabel() {
        label.backgroundColor = .clear
        label.text = "Section Header"
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        backgroundColor = UIColor.darkBlue
        addSubview(label)
    }
    
    private func configureConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
