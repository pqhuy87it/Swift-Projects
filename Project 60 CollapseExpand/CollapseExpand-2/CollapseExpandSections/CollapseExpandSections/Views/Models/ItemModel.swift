//
//  ItemModel.swift
//  CollapseExpandSections
//
//  Created by huy on 2023/07/22.
//

import Foundation

enum CellType: String {
    case ItemA
    case ItemB
    case ItemC
    case ItemD
    case ItemE
}

enum CellState: String {
    case expand
    case collapse
}

class BaseObject {
    
}

class Header: BaseObject {
    var type: CellType
    var title: String
    
    init(title: String, cellType: CellType) {
        self.title = title
        self.type = cellType
    }
}

class Item: BaseObject {
    var type: CellType
    var state: CellState
    
    init(type: CellType, cellState: CellState) {
        self.type = type
        self.state = cellState
    }
}
