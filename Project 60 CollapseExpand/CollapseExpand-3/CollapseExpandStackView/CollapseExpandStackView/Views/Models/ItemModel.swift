//
//  ItemModel.swift
//  CollapseExpandStackView
//
//  Created by huy on 2023/07/22.
//

import Foundation

enum ItemType: String {
    case ItemA
    case ItemB
    case ItemC
    case ItemD
    case ItemE
}

enum ItemState: String {
    case expand
    case collapse
}

class Item {
    var type: ItemType
    var state: ItemState
    var headerTitle: String
    
    init(type: ItemType, state: ItemState, headerTitle: String) {
        self.type = type
        self.state = state
        self.headerTitle = headerTitle
    }
}
