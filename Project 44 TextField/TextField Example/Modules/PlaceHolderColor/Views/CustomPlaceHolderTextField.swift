
import UIKit

class CustomPlaceHolderTextField: UITextField {
    
    fileprivate var _fontSize: CGFloat = 12.0
    fileprivate var _fontName: String = "Helvetica"

    @IBInspectable var color: UIColor? {
        didSet {
            updatePlaceHolder()
        }
    }
    
    @IBInspectable var fontSize: CGFloat {
        set {
            _fontSize = newValue
            self.updatePlaceHolder()
        }
        get {
            return _fontSize
        }
    }
    
    @IBInspectable var fontName: String {
        set {
            _fontName = newValue
            self.updatePlaceHolder()
        }
        get {
            return _fontName
        }
    }

    private func updatePlaceHolder() {
        var attributes: [NSAttributedString.Key: Any] = [:]
        
        if let placeHolderColor = self.color {
            attributes[NSAttributedString.Key.foregroundColor] = placeHolderColor
        }
        
        let font = UIFont(name: _fontName, size: _fontSize)
        
        attributes[NSAttributedString.Key.font] = font
        
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: attributes)
    }
}
