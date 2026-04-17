
import Foundation
import UIKit

class GradientBackgroundView: UIView {
    var startLocation: Double = 0.0 {
        didSet {
            updateLocations()
        }
    }
    
    var endLocation: Double = 1.0 {
        didSet {
            updateLocations()
        }
    }
    
    var startColor: UIColor = .white {
        didSet {
            updateColors()
        }
    }
    
    var endColor: UIColor = .black {
        didSet {
            updateColors()
        }
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    var visualEffectView = VisualEffectView()
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateColors()
        updateLocations()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateLocations() {
        var locations: [NSNumber] = []
        locations.append(self.startLocation as NSNumber)
        locations.append(self.endLocation as NSNumber)
        
        gradientLayer.locations = locations
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    }
    
    func updateColors() {
        var colors: [Any] = []
        colors.append(startColor.cgColor)
        colors.append(endColor.cgColor)
        
        gradientLayer.colors = colors
    }
    
    private func setupViews() {
        self.layer.opacity = 0.61
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(visualEffectView)
        visualEffectView.blurRadius = 40.0
        
        NSLayoutConstraint(item: visualEffectView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: -51.0).isActive = true
        NSLayoutConstraint(item: self.visualEffectView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: 51.0).isActive = true
        NSLayoutConstraint(item: self.visualEffectView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: -28).isActive = true
        NSLayoutConstraint(item: self.visualEffectView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        
    }
}
