//
//  Dictionary+Extension.swift
//  Swift-Extension
//
//  Created by Pham Quang Huy on 2020/10/02.
//  Copyright © 2020 Huy Pham Quang. All rights reserved.
//

import Foundation

extension Dictionary {
    func JsonString() -> String {
        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String.init(data: jsonData, encoding: .utf8)!
        } catch {
            return "error converting"
        }
    }
    
    mutating func uppercasedValues() {
        for (key, value) in self {
            self[key] = String(describing: value).uppercased() as? Value
        }
    }
    
    mutating func lowercaseKeys() {
        for key in self.keys {
            let str = (key as! String).lowercased()
            self[str as! Key] = self.removeValue(forKey: key)
        }
    }
}

protocol LowercaseConvertible {
    var lowercaseString: Self { get }
}

extension String: LowercaseConvertible {
    var lowercaseString: String {
        return self.lowercased()
    }
}

extension Dictionary where Key: LowercaseConvertible {
    func lowercaseKeys() -> Dictionary {
        var newDictionary = Dictionary()
        
        for k in keys {
            newDictionary[k.lowercaseString] = self[k]
        }
        return newDictionary
    }
}
