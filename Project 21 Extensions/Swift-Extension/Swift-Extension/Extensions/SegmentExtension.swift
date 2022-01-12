
import UIKit

extension UIView {
    
    func rounded() {
        let maskPath1 = UIBezierPath(roundedRect: self.bounds,
                                     byRoundingCorners: [.topRight, .topLeft],
                                     cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.path = maskPath1.cgPath
        self.layer.mask = maskLayer1
    }
    
}
