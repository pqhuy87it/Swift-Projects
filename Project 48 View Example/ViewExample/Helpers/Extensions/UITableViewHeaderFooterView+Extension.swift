
import UIKit

// MARK: - Response Identifier
protocol ResponseIdentifier {}

extension ResponseIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}

extension NSObject: ResponseIdentifier {}

extension UITableViewHeaderFooterView {
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
