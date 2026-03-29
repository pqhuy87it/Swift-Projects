//
//  NetworkStatusCode.swift
//  MVVM-UnitTest
//
//  Created by Huy Pham on 2024/04/26.
//

import Foundation

enum NetworkStatusCode: Int {
    // Undefined error
    case undefined              = 0
    // 2xx Success
    case success                = 200
    case noContent              = 204
    // 4xx Client errors
    case badRequest             = 400
    case unauthorized           = 401
    case forbidden              = 403
    case notFound               = 404
    case methodNotAllowed       = 405
    //5xx Server errors
    case internalServerError    = 500
    case notImplemented         = 501
    case badGateway             = 502
    case serviceUnavailable     = 503
    
    init?(_ statusCode: Int?) {
        guard let statusCode = statusCode else {
            self = NetworkStatusCode.undefined
            return
        }
        
        if let value = NetworkStatusCode(rawValue: statusCode) {
            self = value
        } else {
            self = NetworkStatusCode.undefined
        }
    }
}
