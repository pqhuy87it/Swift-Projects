//
//  Item.swift
//  SettingScreen
//
//  Created by Pham Quang Huy on 2020/12/20.
//

import Foundation

enum SettingSectionType {
    case phone
    case privacy
    case general
    
    var description : String {
        switch self {
            case .phone:
                return "iPhone"
            case .privacy:
                return "Privacy"
            case .general:
                return "General"
        }
    }
}

enum SettingItemType {
    // phone
    case airplaneMode
    case wifi
    case bluetooth
    case celluar
    case hotspot
    
    // privacy
    case notifications
    case sound
    case disturb
    case screentime
    
    // general
    case control
    case display
    case homescreen
    case accessibility
    
    var description : String {
        switch self {
            // Use Internationalization, as appropriate.
            case .airplaneMode: return "Airplane Mode"
            case .wifi: return "Wi-Fi"
            case .bluetooth: return "Bluetooth"
            case .celluar: return "Cellular"
            case .hotspot: return "Personal Hotspot"
            case .notifications: return "Notifications"
            case .sound: return "Sounds & Haptics"
            case .disturb: return "Do Not Disturb"
            case .screentime: return "Screen Time"
            case .control: return "Control Center"
            case .display: return "Display & Brightness"
            case .homescreen: return "Home Screen"
            case .accessibility: return "Accessibility"
        }
    }
}

enum DemoCellType {
    case custom
    case apple
    case gmail
    
    var description : String {
        switch self {
            case .custom:
                return "Custom style"
            case .apple:
                return "Apple style"
            case .gmail:
                return "Gmail style"
        }
    }
}
