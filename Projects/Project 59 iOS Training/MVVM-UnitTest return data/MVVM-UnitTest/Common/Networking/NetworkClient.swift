//
//  NetworkClient.swift
//  MVVM-UnitTest
//
//  Created by huy on 2023/07/01.
//

import Foundation
import UIKit

class NetworkClient {
    
    let urlSession: URLSession
    
    init() {
        self.urlSession = URLSession.shared
    }
    
    init(urlSession: URLSession?) {
        if let urlSession = urlSession {
            self.urlSession = urlSession
        } else {
            self.urlSession = URLSession.shared
        }
    }
    
    func execute(_ request: NetworkRequest, completionHandler: @escaping (Result<NetworkResponse>) -> Void) {
        let urlRequest = request.buildURLRequest()
        
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            switch(data, response, error) {
            case(_, _, let error?):
                let networkError = NetworkError(errorCode: nil,
                                                error: error)
                completionHandler(Result(error: networkError))
            case(let data?, let response?, _):
                guard let response = response as? HTTPURLResponse else {
                    let error = NetworkError(errorCode: NetworkErrorCode.nilData,
                                             error: nil)
                    completionHandler(Result(error: error))
                    return
                }
                
                let statusCode = response.statusCode
                let httpStatusCode = HttpStatusCode(statusCode)
                
                if case(200..<300) = statusCode {
                    let response = NetworkResponse(httpStatusCode: httpStatusCode,
                                                   data: data)
                    completionHandler(Result(value: response))
                } else {
                    let networkErrorCode = NetworkErrorCode(httpStatusCode: statusCode)
                    let error = NetworkError(errorCode: networkErrorCode,
                                             error: nil)
                    completionHandler(Result(error: error))
                }
            default:
                let networkErrorCdoe = NetworkErrorCode.unknow
                let error = NetworkError(errorCode: networkErrorCdoe,
                                         error: nil)
                completionHandler(Result(error: error))
            }
        }
        
        dataTask.resume()
    }
}
