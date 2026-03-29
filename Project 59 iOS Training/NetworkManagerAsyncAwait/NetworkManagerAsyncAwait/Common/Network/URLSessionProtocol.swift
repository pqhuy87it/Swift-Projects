//
//  URLSessionProtocol.swift
//  NetworkManagerAsyncAwait
//
//  Created by Huy Pham on 2024/11/01.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSessionProtocol {
    func data(from request: URLRequest) async throws -> (Data, URLResponse) {
        try await data(for: request, delegate: nil)
    }
}

extension URLSession: URLSessionProtocol {}
