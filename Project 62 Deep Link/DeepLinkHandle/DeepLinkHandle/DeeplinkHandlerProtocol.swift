//
//  DeeplinkHandlerProtocol.swift
//  DeepLinkHandle
//
//  Created by huy on 2023/10/07.
//

import Foundation

protocol DeeplinkHandlerProtocol {
    func canOpenURL(_ url: URL) -> Bool
    func openURL(_ url: URL)
}

protocol DeeplinkCoordinatorProtocol {
    @discardableResult
    func handleURL(_ url: URL) -> Bool
}
