//
//  URLSessionMockClass.swift
//  NetworkManagerAsyncAwait
//
//  Created by Huy Pham on 2024/11/01.
//

import Foundation

final class URLSessionMockClass: URLSessionProtocol {
    var data: Data?
    var error: Error?
    var url: URL?
    var statusCode: Int?
    
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        let defaultUrl = URL(string: "https://www.google.com")!
        let response = HTTPURLResponse(url: request.url ?? defaultUrl,
                                       statusCode: statusCode ?? 0,
                                       httpVersion: nil,
                                       headerFields: nil)
        
        return (data ?? Data(), response!)
    }
}
