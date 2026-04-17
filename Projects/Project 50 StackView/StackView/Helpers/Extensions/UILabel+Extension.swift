
import UIKit

extension UILabel {
    static func makeLabel(_ text: String, fontSize: CGFloat, textColor: UIColor, backgroundColor: UIColor) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.text = text
        label.textAlignment = .center
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        return label
    }
}
