
import UIKit

class VisualEffectView: UIVisualEffectView {

    private let blurEffect = (NSClassFromString("_UICustomBlurEffect") as! UIBlurEffect.Type).init()

    open var colorTint: UIColor? {
        get { return _value(forKey: "colorTint") as? UIColor }
        set { _setValue(newValue, forKey: "colorTint") }
    }
    
    open var colorTintAlpha: CGFloat {
        get { return _value(forKey: "colorTintAlpha") as! CGFloat }
        set { _setValue(newValue, forKey: "colorTintAlpha") }
    }
    
    open var blurRadius: CGFloat {
        get { return _value(forKey: "blurRadius") as! CGFloat }
        set { _setValue(newValue, forKey: "blurRadius") }
    }
    
    open var scale: CGFloat {
        get { return _value(forKey: "scale") as! CGFloat }
        set { _setValue(newValue, forKey: "scale") }
    }
    
    public override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        scale = 1
    }
    
    private func _value(forKey key: String) -> Any? {
        return blurEffect.value(forKeyPath: key)
    }
    
    private func _setValue(_ value: Any?, forKey key: String) {
        blurEffect.setValue(value, forKey: key)
        self.effect = blurEffect
    }
}
