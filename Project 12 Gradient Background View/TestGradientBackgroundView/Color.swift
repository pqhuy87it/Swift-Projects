
import Foundation
import UIKit

enum Color {
    case greenGradationTop
    case greenGradationBottom
    case incomeNormal
    case expenseNormal
    case primary
    case accent_primary
    case Secondary01
    case Secondary02
    case Secondary03
    case Secondary04
    case Secondary05
    case Secondary06
    case Secondary07
    case menuInfo
    case menu_koza_1
    case menu_koza_2
    case grayDisable
    case gray20
    case validateError
    
    func withAlpha(_ alpha: CGFloat) -> UIColor {
        return self.value.withAlphaComponent(alpha)
    }
}

extension Color {
    var value: UIColor {
        var instanceColor = UIColor.clear
        
        switch self {
        case .greenGradationTop:
            instanceColor = UIColor(hex: "#009900")
        case .greenGradationBottom:
            instanceColor = UIColor(hex: "#9DC816")
        case .incomeNormal:
            instanceColor = UIColor(r: 168, g: 208, b: 240)
        case .expenseNormal:
            instanceColor = UIColor(r: 240, g: 168, b: 176)
        case .primary:
            instanceColor = UIColor(hex: "#009900")
        case .accent_primary:
            instanceColor = UIColor(hex: "#009900").withAlphaComponent(0.5)
        case .Secondary01:
            instanceColor = UIColor(hex: "#F2FAF2")
        case .Secondary02:
            instanceColor = UIColor(hex: "#F3F4F3")
        case .Secondary03:
            instanceColor = UIColor(hex: "#E5F4E5")
        case .Secondary04:
            instanceColor = UIColor(hex: "#CCEBCC")
        case .Secondary05:
            instanceColor = UIColor(hex: "#99D699")
        case .Secondary06:
            instanceColor = UIColor(hex: "#66C266")
        case .Secondary07:
            instanceColor = UIColor(hex: "#33AD33")
        case .menuInfo:
            instanceColor = UIColor(hex: "#D6EA79")
        case .menu_koza_1:
            instanceColor = UIColor(hex: "#EDAE93")
        case .menu_koza_2:
            instanceColor = UIColor(hex: "#EDCC93")
        case .grayDisable:
            instanceColor = UIColor(hex: "#EBEBEB")
        case .gray20:
            instanceColor = UIColor(hex: "#EFEFEF")
        case .validateError:
            instanceColor = UIColor(hex: "#F04830")
        }
        
        return instanceColor
    }
}

extension UIColor {
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: 1)
    }
    
    convenience init(grayScale: Int) {
        self.init(red: CGFloat(grayScale) / 255, green: CGFloat(grayScale) / 255, blue: CGFloat(grayScale) / 255, alpha: 1)
    }
    
    convenience init(hex: String) {
        
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
            return
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    //    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
    //        if #available(iOS 10.0, *) {
    //            return UIGraphicsImageRenderer(size: size).image { renderContext in
    //                self.setFill()
    //                renderContext.fill(CGRect(origin: .zero, size: size))
    //            }
    //        } else {
    //            // Fallback on earlier versions
    //            return UIImage()
    //        }
    //    }
    
}
