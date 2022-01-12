
import UIKit

extension UIView {
    class func fromNib() -> UIView? {
        return Bundle(for: self).loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as? UIView
    }

	func pinToSuperview(_ insets:NSDirectionalEdgeInsets = .zero) {
		guard let sup = self.superview else { return }
		self.translatesAutoresizingMaskIntoConstraints = false
		self.topAnchor.constraint(equalTo: sup.topAnchor, constant: insets.top).isActive = true
		self.trailingAnchor.constraint(equalTo: sup.trailingAnchor, constant: -insets.trailing).isActive = true
		self.leadingAnchor.constraint(equalTo: sup.leadingAnchor, constant: insets.leading).isActive = true
		self.bottomAnchor.constraint(equalTo: sup.bottomAnchor, constant: -insets.bottom).isActive = true
	}
}
