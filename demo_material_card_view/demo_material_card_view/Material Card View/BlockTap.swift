//
//  BlockTap.swift
//  demo_material_card_view
//
//  Created by huy on 2025/12/27.
//

import Foundation
import UIKit

// Wrapper để dùng closure cho Gesture
class BlockTap: UITapGestureRecognizer {
    private var tapAction: ((UITapGestureRecognizer) -> Void)?
    
    init(tapCount: Int, fingerCount: Int, action: ((UITapGestureRecognizer) -> Void)?) {
        self.tapAction = action
        super.init(target: nil, action: nil)
        self.numberOfTapsRequired = tapCount
        self.numberOfTouchesRequired = fingerCount
        self.addTarget(self, action: #selector(didTap(_:)))
    }
    
    @objc func didTap(_ tap: UITapGestureRecognizer) {
        tapAction?(tap)
    }
}
