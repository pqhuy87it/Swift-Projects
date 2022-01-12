
import Foundation
import UIKit

extension UIDevice {
    enum ScreenSize: String {
        case iphone_4_Inch = "iphone 5, iphone 5s, iphone SE"
        case iphone_4_7_Inch = "iphone 6, iphone 6s, iphone 7, iphone 8"
        case iphone_5_5_Inch = "iphone 6 plus, iphone 6s plush, iphone 7 plus, iphone 8 plus"
        case iphone_5_8_Inch = "iphone XR"
        case iphone_6_1_Inch = "iphone x, iphone xs"
        case iphone_6_5_Inch = "iphone xs max"
        case unknow = "iphone does not exist"
    }
    
    var screenSize: ScreenSize {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            return .iphone_4_Inch
        case 1334:
            return .iphone_4_7_Inch
        case 1792:
            return .iphone_5_8_Inch
        case 1920, 2208:
            return .iphone_5_5_Inch
        case 2436:
            return .iphone_6_1_Inch
        case 2688:
            return .iphone_6_5_Inch
        default:
            return .unknow
        }
    }
    
    var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }

    var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    var isTV: Bool {
        return UIDevice.current.userInterfaceIdiom == .tv
    }

    var isCarPlay: Bool {
        return UIDevice.current.userInterfaceIdiom == .carPlay
    }
}
