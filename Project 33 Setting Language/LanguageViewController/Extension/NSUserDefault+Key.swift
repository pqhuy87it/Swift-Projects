//
//  NSUserDefault+Key.swift
//  LanguageViewController
//
//  Created by Pham Quang Huy on 1/30/18.
//  Copyright © 2018 Pham Quang Huy. All rights reserved.
//

import Foundation

let kStoreKeyPrefix = "seven.test-"

extension UserDefaults {
    enum Key: String {
        case Language = "jgewiodshtalewirbng;iew;o"
        
        func forStoreString() -> String {
            return kStoreKeyPrefix + self.rawValue
        }
    }
    
    func valueForKey(_ key: Key) -> AnyObject? {
        return self.value(forKey: key.forStoreString()) as AnyObject?
    }
    
    func setInteger(_ value: Int, forKey key: Key) {
        self.set(value, forKey: key.forStoreString())
    }
}
