
import UIKit

class ViewController: UIViewController {

    @IBOutlet var testView: TestRoundedCornerViews!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnDidTap(_ sender: Any) {
        testView.doAnim()
    }
    
}

class TestRoundedCornerViews: UIView {
    
    let shapeLayer = CAShapeLayer()
    var startPath: UIBezierPath!
    var endPath: UIBezierPath!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    func commonInit() {

        shapeLayer.fillColor = UIColor.lightGray.cgColor
        
        // if you want to watch the path border instead
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 1
        
        layer.addSublayer(shapeLayer)

    }
    
    func doAnim() {
        
        let animation1 = CABasicAnimation(keyPath: "path")
        animation1.fromValue = startPath.cgPath
        animation1.toValue = endPath.cgPath
        animation1.duration = 0.5
        animation1.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation1.fillMode = .both
        
        // un-comment next two lines to repeat and auto-revers
        animation1.repeatCount = .greatestFiniteMagnitude
        animation1.autoreverses = true
        
        animation1.isRemovedOnCompletion = false
        
        shapeLayer.add(animation1, forKey: animation1.keyPath)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let cr: CGFloat = 16
        
        let oneThirdWidth: CGFloat = bounds.width * 1.0 / 3.0
        let twoThirdWidth: CGFloat = oneThirdWidth * 2.0

        let oneThirdHeight: CGFloat = bounds.height * 1.0 / 3.0
        let twoThirdHeight: CGFloat = oneThirdHeight * 2.0

        // centers for startPath arcs (rounded corners)

        // top-left corner - will not change
        let c1: CGPoint = .init(x: cr, y: bounds.minY + cr)
        
        var c2: CGPoint = .init(x: twoThirdWidth - cr, y: bounds.minY + cr)
        var c3: CGPoint = .init(x: twoThirdWidth + cr, y: oneThirdHeight - cr)
        var c4: CGPoint = .init(x: bounds.maxX - cr, y: oneThirdHeight + cr)
        var c5: CGPoint = .init(x: bounds.maxX - cr, y: twoThirdHeight - cr)
        var c6: CGPoint = .init(x: twoThirdWidth + cr, y: twoThirdHeight + cr)
        var c7: CGPoint = .init(x: twoThirdWidth - cr, y: bounds.maxY - cr)
        
        // bottom-left corner - will not change
        let c8: CGPoint = .init(x: cr, y: bounds.maxY - cr)
        
        startPath = UIBezierPath()
        startPath.move(to: .init(x: 0.0, y: cr))
        startPath.addArc(withCenter: c1, radius: cr, startAngle: .pi * 1.0, endAngle: .pi * 1.5, clockwise: true)
        startPath.addArc(withCenter: c2, radius: cr, startAngle: .pi * 1.5, endAngle: .pi * 2.0, clockwise: true)
        startPath.addArc(withCenter: c3, radius: cr, startAngle: .pi * 1.0, endAngle: .pi * 0.5, clockwise: false)
        startPath.addArc(withCenter: c4, radius: cr, startAngle: .pi * 1.5, endAngle: .pi * 2.0, clockwise: true)
        startPath.addArc(withCenter: c5, radius: cr, startAngle: .pi * 0.0, endAngle: .pi * 0.5, clockwise: true)
        startPath.addArc(withCenter: c6, radius: cr, startAngle: .pi * 1.5, endAngle: .pi * 1.0, clockwise: false)
        startPath.addArc(withCenter: c7, radius: cr, startAngle: .pi * 0.0, endAngle: .pi * 0.5, clockwise: true)
        startPath.addArc(withCenter: c8, radius: cr, startAngle: .pi * 0.5, endAngle: .pi * 1.0, clockwise: true)
        startPath.close()
        
        shapeLayer.path = startPath.cgPath
        
        // centers for endPath arcs (rounded corners)
        c2 = .init(x: bounds.maxX - cr, y: bounds.minY)
        c3 = .init(x: bounds.maxX - cr, y: bounds.minY)
        c4 = .init(x: bounds.maxX - cr, y: cr)
        c5 = .init(x: bounds.maxX - cr, y: bounds.maxY - cr)
        c6 = .init(x: bounds.maxX - cr, y: bounds.maxY)
        c7 = .init(x: bounds.maxX - cr, y: bounds.maxY)
        
        endPath = UIBezierPath()
        endPath.move(to: .init(x: 0.0, y: cr))
        endPath.addArc(withCenter: c1, radius: cr, startAngle: .pi * 1.0, endAngle: .pi * 1.5, clockwise: true)
        endPath.addArc(withCenter: c2, radius: 0.0, startAngle: .pi * 1.5, endAngle: .pi * 2.0, clockwise: true)
        endPath.addArc(withCenter: c3, radius: 0.0, startAngle: .pi * 1.0, endAngle: .pi * 0.5, clockwise: false)
        endPath.addArc(withCenter: c4, radius: cr, startAngle: .pi * 1.5, endAngle: .pi * 2.0, clockwise: true)
        endPath.addArc(withCenter: c5, radius: cr, startAngle: .pi * 0.0, endAngle: .pi * 0.5, clockwise: true)
        endPath.addArc(withCenter: c6, radius: 0.0, startAngle: .pi * 1.5, endAngle: .pi * 1.0, clockwise: false)
        endPath.addArc(withCenter: c7, radius: 0.0, startAngle: .pi * 0.0, endAngle: .pi * 0.5, clockwise: true)
        endPath.addArc(withCenter: c8, radius: cr, startAngle: .pi * 0.5, endAngle: .pi * 1.0, clockwise: true)
        endPath.close()

    }

}

