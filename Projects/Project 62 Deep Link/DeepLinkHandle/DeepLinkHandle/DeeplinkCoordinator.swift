//
//  DeeplinkCoordinator.swift
//  DeepLinkHandle
//
//  Created by huy on 2023/10/07.
//

import Foundation

final class DeeplinkCoordinator {
    
    let handlers: [DeeplinkHandlerProtocol]
    
    init(handlers: [DeeplinkHandlerProtocol]) {
        self.handlers = handlers
    }
}

extension DeeplinkCoordinator: DeeplinkCoordinatorProtocol {
    
    @discardableResult
    func handleURL(_ url: URL) -> Bool {
        guard let handler = handlers.first(where: { $0.canOpenURL(url) }) else {
            return false
        }
              
        handler.openURL(url)
        return true
    }
}
