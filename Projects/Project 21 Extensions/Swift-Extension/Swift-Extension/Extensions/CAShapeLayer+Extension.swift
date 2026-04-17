

import Foundation
import UIKit

extension CAShapeLayer {
    func animateStrokeEnd(from: CGFloat, to: CGFloat) {
        self.strokeEnd = from
        self.strokeEnd = to
    }
    
    func animatePath(start: CGPath, end: CGPath) {
        removeAllAnimations()
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = start
        animation.toValue = end
        animation.isRemovedOnCompletion = true
        add(animation, forKey: "pathAnimation")
    }
}
