
import UIKit

extension UIStackView {
    @discardableResult
    func addBackground(color: UIColor, radius: CGFloat = 0) -> UIView {
        return addUnarrangedView(color: color, radius: radius, at: 0)
    }
    
    @discardableResult
    func addForeground(color: UIColor, radius: CGFloat = 0) -> UIView {
        let index = subviews.count
        return addUnarrangedView(color: color, radius: radius, at: index)
    }
    
    @discardableResult
    func addUnarrangedView(color: UIColor, radius: CGFloat = 0, at index: Int = 0) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        view.layer.cornerRadius = radius
        insertSubview(view, at: index)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        return view
    }
}
