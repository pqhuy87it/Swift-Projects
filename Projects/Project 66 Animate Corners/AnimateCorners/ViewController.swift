
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testView: AnimCornerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btn1DidTap(_ sender: Any) {
        testView.setCorners(topLeft: 10, topRight: 10, botLeft: 10, botRight: 10, animated: true)
    }
    
    @IBAction func btn2DidTap(_ sender: Any) {
        testView.setCorners(topLeft: 0, topRight: 0, botLeft: 0, botRight: 0, animated: true)
    }
}

class AnimCornerView: UIView  {
    
    public var fillColor: UIColor = .orange
    public var borderColor: UIColor = .clear
    public var borderWidth: CGFloat = 0.0

    private var _tl: CGFloat = 0
    private var _tr: CGFloat = 0
    private var _bl: CGFloat = 0
    private var _br: CGFloat = 0

    private var theShapeLayer: CAShapeLayer!
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    func commonInit() -> Void {
        backgroundColor = .clear
        theShapeLayer = self.layer as? CAShapeLayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setCorners(topLeft: _tl, topRight: _tr, botLeft: _bl, botRight: _br, animated: false)
    }

    public func setCorners(topLeft tl: CGFloat, topRight tr: CGFloat, botLeft bl: CGFloat, botRight br: CGFloat, animated: Bool, duration: CFTimeInterval = 0.3) -> Void {
        
        _tl = tl
        _tr = tr
        _bl = bl
        _br = br
        
        theShapeLayer.fillColor = fillColor.cgColor
        theShapeLayer.strokeColor = borderColor.cgColor
        theShapeLayer.lineWidth = borderWidth
        
        let newPath: CGPath = getPath(topLeft: tl, topRight: tr, botLeft: bl, botRight: br)
        
        if animated {
            
            CATransaction.begin()
            
            let animation = CABasicAnimation(keyPath: "path")
            animation.duration = duration
            animation.toValue = newPath
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
            
            CATransaction.setCompletionBlock({
                self.theShapeLayer.path = newPath
                self.theShapeLayer.removeAllAnimations()
            })
            
            self.theShapeLayer.add(animation, forKey: "path")
            
            CATransaction.commit()
            
        } else {
            
            theShapeLayer.path = newPath
            
        }
        
    }
    
    private func getPath(topLeft tl: CGFloat, topRight tr: CGFloat, botLeft bl: CGFloat, botRight br: CGFloat) -> CGPath {
        
        var pt = CGPoint.zero
        
        let myBezier = UIBezierPath()
        
        // top-left corner plus top-left radius
        pt.x = tl
        pt.y = 0
        
        myBezier.move(to: pt)
        
        pt.x = bounds.maxX - tr
        pt.y = 0
        
        // add "top line"
        myBezier.addLine(to: pt)
        
        pt.x = bounds.maxX - tr
        pt.y = tr

        // add "top-right corner"
        myBezier.addArc(withCenter: pt, radius: tr, startAngle: .pi * 1.5, endAngle: 0, clockwise: true)
        
        pt.x = bounds.maxX
        pt.y = bounds.maxY - br
        
        // add "right-side line"
        myBezier.addLine(to: pt)
        
        pt.x = bounds.maxX - br
        pt.y = bounds.maxY - br
        
        // add "bottom-right corner"
        myBezier.addArc(withCenter: pt, radius: br, startAngle: 0, endAngle: .pi * 0.5, clockwise: true)
        
        pt.x = bl
        pt.y = bounds.maxY
        
        // add "bottom line"
        myBezier.addLine(to: pt)
        
        pt.x = bl
        pt.y = bounds.maxY - bl
        
        // add "bottom-left corner"
        myBezier.addArc(withCenter: pt, radius: bl, startAngle: .pi * 0.5, endAngle: .pi, clockwise: true)
        
        pt.x = 0
        pt.y = tl
        
        // add "left-side line"
        myBezier.addLine(to: pt)
        
        pt.x = tl
        pt.y = tl
        
        // add "top-left corner"
        myBezier.addArc(withCenter: pt, radius: tl, startAngle: .pi, endAngle: .pi * 1.5, clockwise: true)
        
        myBezier.close()
        
        return myBezier.cgPath
        
    }
    
}
