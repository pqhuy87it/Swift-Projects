
import UIKit

class MainNavigationController: UINavigationController {

}

class MainTabBarViewController: UITabBarController {

}

extension UIViewController {
    var mainNavigationViewController: MainNavigationController? {
        if let _mainNavigationController = self.navigationController as? MainNavigationController {
            return _mainNavigationController
        }
        
        if let _mainNavigationController = self.view.window?.rootViewController as? MainNavigationController {
            return _mainNavigationController
        }
        
        return nil
    }
    
    var mainTabBarController: MainTabBarViewController? {
        if let viewControllers = mainNavigationViewController?.viewControllers.filter({ $0.isKind(of: MainTabBarViewController.self)}), let mainTabBarVC = viewControllers.first as? MainTabBarViewController {
            return mainTabBarVC
        }
        
        return nil
    }
    
    static func withIdentifier(_ identifier: String, storyboardName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    static func fromStoryboard(_ storyboardName: String) -> UIViewController {
        let identifier = String(describing: self)
        return UIViewController.withIdentifier(identifier, storyboardName: storyboardName)
    }
}
