
import UIKit

class CustomTextField : UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        print(bounds)
        return super.textRect(forBounds:bounds)
        // prints a lot of times, and with wrong bounds most of them
    }
}
