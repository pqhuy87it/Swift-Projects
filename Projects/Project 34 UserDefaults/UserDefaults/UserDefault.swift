//
//  UserDefault.swift
//  UserDefaults
//
//  Created by Pham Quang Huy on 2020/12/13.
//

import Foundation
import UIKit

private enum UserDefaultKeys: String {
    case appVersion = "App Version"
    case firstLaunch = "App First Launch"
}

public class UserDefault {
    // MARK: - Private Function
    
    private static func _set(value: Any?, key: UserDefaultKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    private static func _get(valueForKay key: UserDefaultKeys) -> Any? {
        return UserDefaults.standard.value(forKey: key.rawValue)
    }
    
    // MARK: - Variables
    
    static var version: Float {
        get {
            return (_get(valueForKay: .appVersion) as? Float) ?? 0.0
        }
        set {
            _set(value: newValue, key: .appVersion)
        }
    }
    
    static var isFirstLaunch: Bool {
        get {
            return (_get(valueForKay: .firstLaunch) as? Bool) ?? false
        }
        set {
            _set(value: newValue, key: .firstLaunch)
        }
    }
}
