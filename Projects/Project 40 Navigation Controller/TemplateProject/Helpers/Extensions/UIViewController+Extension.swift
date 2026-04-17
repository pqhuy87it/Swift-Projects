
import UIKit

extension UIViewController {
    static func withIdentifier(_ identifier: String, storyboardName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    static func fromStoryboard(_ storyboardName: String) -> UIViewController {
        let identifier = String(describing: self)
        return UIViewController.withIdentifier(identifier, storyboardName: storyboardName)
    }
}
