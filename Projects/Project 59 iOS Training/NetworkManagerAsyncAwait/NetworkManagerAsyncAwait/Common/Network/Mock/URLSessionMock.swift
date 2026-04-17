//
//  URLSessionMock.swift
//  MVVM-UnitTest
//
//  Created by Huy Pham on 2024/04/26.
//

import Foundation

protocol URLSessionMockProtocol {
    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSessionMockProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse) {
        try await data(from: url, delegate: nil)
    }
}

extension URLSession: URLSessionMockProtocol {}


