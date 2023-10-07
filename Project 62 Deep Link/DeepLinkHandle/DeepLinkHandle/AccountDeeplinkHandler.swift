//
//  AccountDeeplinkHandler.swift
//  DeepLinkHandle
//
//  Created by huy on 2023/10/07.
//

import UIKit

final class AccountDeeplinkHandler: DeeplinkHandlerProtocol {
    
    private weak var rootViewController: UIViewController?
    init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
    
    // MARK: - DeeplinkHandlerProtocol
    
    func canOpenURL(_ url: URL) -> Bool {
        return url.absoluteString == "deeplink://account"
    }
    
    func openURL(_ url: URL) {
        guard canOpenURL(url) else {
            return
        }
        
        // mock the navigation
        let viewController = UIViewController()
        viewController.title = "Account"
        viewController.view.backgroundColor = .yellow
        rootViewController?.present(viewController, animated: true)
    }
}
