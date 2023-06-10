
import Foundation
import UIKit

extension UIColor {
    static var Black : UIColor {get{return UIColor.colorFromHex(0x000000)}}
    static var Gray0 : UIColor {get{return UIColor.colorFromHex(0x333333)}}
    static var Gray1 : UIColor {get{return UIColor.colorFromHex(0x666666)}}
    static var Gray2 : UIColor {get{return UIColor.colorFromHex(0x999999)}}
    static var Gray3 : UIColor {get{return UIColor.colorFromHex(0xCCCCCC)}}
    static var Gray4 : UIColor {get{return UIColor.colorFromHex(0xDDDDDD)}}
    static var Gray5 : UIColor {get{return UIColor.colorFromHex(0xF0F0F0)}}
    static var Gray6 : UIColor {get{return UIColor.colorFromHex(0xF5F5F5)}}
    static var Gray7 : UIColor {get{return UIColor.colorFromHex(0xE7E7E7)}}
    static var Gray8 : UIColor {get{return UIColor.colorFromHex(0xB2B2B2)}}
    
    static var darkestBlue: UIColor {get{return UIColor.colorFromHex(0x230A59)}}
    static var darkBlue: UIColor {get{return UIColor.colorFromHex(0x3E38F2)}}
    static var royalBlue: UIColor {get{return UIColor.colorFromHex(0x0029FA)}}
    static var paleBlue: UIColor {get{return UIColor.colorFromHex(0x5C73F2)}}
    static var palestBlue: UIColor {get{return UIColor.colorFromHex(0x829FD9)}}

    static func colorFromHex(_ rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }

    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: 1)
    }

    class func color(_ red: Int, green: Int, blue: Int) -> UIColor {
        return UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
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
}
