
import UIKit

extension UISegmentedControl {
    func setTitleTextAttributes(_ hex:String,_ fontSize:CGFloat,_ state:UIControl.State) {
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor :UIColor(hex: hex) ,NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: fontSize)], for: state)
    }
}
