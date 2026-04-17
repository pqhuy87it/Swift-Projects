
import UIKit

struct Constants {

    /// Default duration for present and dismiss animations when the user hasn't
    /// specified one
    static let defaultAnimationDuration: TimeInterval = 0.3

    /// The corner radius applied to the presenting and presented view
    /// controllers's views
    static let cornerRadius: CGFloat = 8

    /// The alpha value of the presented view controller's view
    static let alphaForPresentingView: CGFloat = 0.8

    /// As best as I can tell using my iPhone and a bunch of iOS UI templates I
    /// came across online, 8 points is the distance between the top edges of
    /// the presented and the presenting views
    static let insetForPresentedView: CGFloat = 8

}

final class RoundedView: UIView {
    
    // MARK: - Public variables
    
    public var cornerRadius = Constants.cornerRadius {
        didSet {
            leftCorner.cornerRadius = cornerRadius
            rightCorner.cornerRadius = cornerRadius
        }
    }
    
    // MARK: - Private variables
    
    private let leftCorner = CornerView()
    private let rightCorner = CornerView()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        leftCorner.corner = .topLeft
        rightCorner.corner = .topRight
        
        leftCorner.cornerRadius = cornerRadius
        rightCorner.cornerRadius = cornerRadius
        
        leftCorner.translatesAutoresizingMaskIntoConstraints = false
        rightCorner.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(leftCorner)
        addSubview(rightCorner)
    }
    
    // MARK: - UIView methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        leftCorner.frame = bounds
        rightCorner.frame = bounds
    }
    
}
