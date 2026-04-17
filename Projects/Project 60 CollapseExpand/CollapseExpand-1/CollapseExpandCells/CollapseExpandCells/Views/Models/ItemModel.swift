//
//  ItemModel.swift
//  CollapseExpandCells
//
//  Created by huy on 2023/07/22.
//

import Foundation

enum CellType: String {
    case ItemA
    case ItemB
    case ItemC
    case ItemD
}

enum CellState: String {
    case expand
    case collapse
}

struct Item {
    var type: CellType
    var state: CellState
    
    init(type: CellType, cellState: CellState) {
        self.type = type
        self.state = cellState
    }
}
