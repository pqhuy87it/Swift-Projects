
import Foundation
import UIKit

extension UITableView {
    func registerCellByNib<T: UITableViewCell>(_ type: T.Type) {
        register(type.nib, forCellReuseIdentifier: type.identifier)
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ type: T.Type) {
        register(type.nib, forHeaderFooterViewReuseIdentifier: type.identifier)
    }
    
    func dequeueCell<T: UITableViewCell>(_ type: T.Type, forIndexPath indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
    }
    
    func dequeueCell<T: UITableViewCell>(_ type: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier) as? T
    }
    
    func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(_ type: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: type.identifier) as? T
    }
    
    func reloadData(withAnimation animation: UITableView.RowAnimation) {
        self.reloadSections(IndexSet(integersIn: 0..<numberOfSections), with: animation)
    }
}
