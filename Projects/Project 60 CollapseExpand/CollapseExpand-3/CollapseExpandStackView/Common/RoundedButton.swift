//
//  RoundedButton.swift
//  CollapseExpandStackView
//
//  Created by huy on 2023/07/30.
//

import UIKit

class RoundedButton: UIButton {

    public struct PolygonPoint {
        let point: CGPoint
        let isRounded: Bool
        let customCornerRadius: CGFloat?
        init(point: CGPoint,
             isRounded: Bool,
             customCornerRadius: CGFloat? = nil) {
            self.point = point
            self.isRounded = isRounded
            self.customCornerRadius = customCornerRadius
        }

        init(previousPoint: PolygonPoint, isRounded: Bool) {
            self.init(point: previousPoint.point, isRounded: isRounded, customCornerRadius: previousPoint.customCornerRadius)
        }
    }
    
    var points = [PolygonPoint]()
    
    // MARK: Initializer
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        self.shapeLayer.fillColor = UIColor.orange.cgColor
        self.layer.addSublayer(self.shapeLayer)
    }
    
    var shapeLayer = CAShapeLayer()
    
    // This class var causes the view's base layer to be a CAShapeLayer.
    class override var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    func buildPolygonPathFrom(points: [PolygonPoint], defaultCornerRadius: CGFloat) -> CGPath {
       guard points.count >= 3 else { return CGPath(rect: CGRect.zero, transform: nil) }
       let first = points.first!
       let last = points.last!

       let path = CGMutablePath()

       // Start at the midpoint between the first and last vertex in our polygon
       // (Since that will always be in the middle of a straight line segment.)
       let midpoint = CGPoint(x: (first.point.x + last.point.x) / 2, y: (first.point.y + last.point.y) / 2)
       path.move(to: midpoint)

       //Loop through the points in our polygon.
       for (index, point) in points.enumerated() {
           //Draw an arc from the previous vertex (the current point), around this vertex, and pointing to the next
           let nextIndex = (index+1) % points.count
           let nextPoint = points[nextIndex]
           var radius: CGFloat = 0 // For non-rounded points, use an arc radius of 0 (allows us to animate between rounded/non-rounded corners.)
           if point.isRounded {
               radius = point.customCornerRadius ?? defaultCornerRadius
           }
           path.addArc(tangent1End: point.point, tangent2End: nextPoint.point, radius: radius)
       }

       // Close the path by drawing a line from the last vertex/corner to the midpoint between the last and first point
       path.addLine(to: midpoint)

       return path
   }
    
    func updatePath() {
        let newPath = buildPolygonPathFrom(points: points, defaultCornerRadius: 10)
        if  self.shapeLayer.path == nil {
            self.shapeLayer.path = newPath
        } else {
            CATransaction.begin()
            
            CATransaction.setCompletionBlock {
                DispatchQueue.main.async {
                    self.shapeLayer.path = newPath
                }
            }
            
            let animation = CABasicAnimation(keyPath: "path")
            animation.duration = 0.3
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            animation.fromValue = self.shapeLayer.path
            animation.toValue = newPath
            self.shapeLayer.add(animation, forKey: nil)
            
            CATransaction.commit()
        }
    }
    
    func updateUI(rect: CGRect, state: ItemState) {
        let cornerRadius = 10.0
        
        if state == .expand {
            self.points =  [
                PolygonPoint(point: rect.origin, isRounded: true, customCornerRadius: cornerRadius),
                PolygonPoint(point: CGPoint(x: rect.maxX, y: rect.origin.y), isRounded: true, customCornerRadius: cornerRadius),
                PolygonPoint(point: CGPoint(x: rect.maxX, y: rect.maxY), isRounded: true, customCornerRadius: cornerRadius),
                PolygonPoint(point: CGPoint(x: rect.origin.x, y: rect.maxY), isRounded: true, customCornerRadius: cornerRadius),
            ]
        } else {
            self.points =  [
                PolygonPoint(point: rect.origin, isRounded: true, customCornerRadius: cornerRadius),
                PolygonPoint(point: CGPoint(x: rect.maxX, y: rect.origin.y), isRounded: true, customCornerRadius: cornerRadius),
                PolygonPoint(point: CGPoint(x: rect.maxX, y: rect.maxY), isRounded: false, customCornerRadius: cornerRadius),
                PolygonPoint(point: CGPoint(x: rect.origin.x, y: rect.maxY), isRounded: false, customCornerRadius: cornerRadius),
            ]
        }
        
        self.updatePath()
    }
}
