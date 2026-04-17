//
//  DataItem.swift
//  CollapseExpandStackView
//
//  Created by huy on 2023/07/22.
//

import Foundation
import UIKit

class DataItem : Equatable {
    
    var indexes: String
    var colour: UIColor
    init(_ indexes: String, _ colour: UIColor = UIColor.clear) {
        self.indexes    = indexes
        self.colour     = colour
    }
    
    static func ==(lhs: DataItem, rhs: DataItem) -> Bool {
        return lhs.indexes == rhs.indexes && lhs.colour == rhs.colour
    }
}
