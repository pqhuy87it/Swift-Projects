//
//  URLSessionMock.swift
//  MVVM-UnitTest
//
//  Created by Huy Pham on 2024/04/26.
//

import Foundation

class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    var data: Data?
    var error: Error?
    var url: URL?
    var statusCode: Int?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        let defaultUrl = URL(string: "https://www.google.com")!
        let response = HTTPURLResponse(url: url ?? defaultUrl, statusCode: statusCode ?? 0, httpVersion: nil, headerFields: nil)

        return URLSessionDataTaskMock {
            completionHandler(data, response, error)
        }
    }
}
