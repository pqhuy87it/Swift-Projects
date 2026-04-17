
import UIKit
import UIKit.UIGestureRecognizerSubclass

class CheckboxGestureRecognizer: UILongPressGestureRecognizer {
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
        // Set the minimium press duration to 0.0 to allow for basic taps.
        minimumPressDuration = 0.0
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        // Check whether the touch is outside of the M13Checkbox's bounds, and fail to recognize if so.
        if let anyTouch = touches.first, let view = view {
            let touchPoint = anyTouch.location(in: view)
            if !view.bounds.contains(touchPoint) {
                state = .failed
            }
        }
        
        // If `self.state` is not yet set, the superclass implementation of this method will set it as it sees fit.
        super.touchesEnded(touches, with: event)
    }
}
