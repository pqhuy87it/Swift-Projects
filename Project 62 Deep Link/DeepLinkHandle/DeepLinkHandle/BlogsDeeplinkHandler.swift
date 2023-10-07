//
//  BlogsDeeplinkHandler.swift
//  DeepLinkHandle
//
//  Created by huy on 2023/10/07.
//

import UIKit

final class BlogsDeeplinkHandler: DeeplinkHandlerProtocol {
    
    private weak var rootViewController: UIViewController?
    init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
    
    // MARK: - DeeplinkHandlerProtocol
    
    func canOpenURL(_ url: URL) -> Bool {
        return url.absoluteString.hasPrefix("deeplink://blogs")
    }
    
    func openURL(_ url: URL) {
        guard canOpenURL(url) else {
            return
        }
        
        // mock the navigation
        let viewController = UIViewController()
        switch url.path {
        case "/new":
            viewController.title = "Blog Editing"
            viewController.view.backgroundColor = .orange
        default:
            viewController.title = "Blog Listing"
            viewController.view.backgroundColor = .cyan
        }
        
        rootViewController?.present(viewController, animated: true)
    }
}
