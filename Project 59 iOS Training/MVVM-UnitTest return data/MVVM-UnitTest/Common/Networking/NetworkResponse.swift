//
//  NetworkResponse.swift
//  MVVM-UnitTest
//
//  Created by huy on 2023/07/01.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(NetworkError)
    
    init(value: T) {
        self = .success(value)
    }
    
    init(error: NetworkError){
        self = .failure(error)
    }
}

enum HttpStatusCode: Int {
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
            self = HttpStatusCode.undefined
            return
        }
        
        if let value = HttpStatusCode(rawValue: statusCode) {
            self = value
        } else {
            self = HttpStatusCode.undefined
        }
    }
}

enum NetworkErrorCode {
    case noContent
    case unknow
    case nilData
    case unauthorized
    case badRequest
    case notFound
    case forbidden
    case userNotFound
    case logoutError
    case loginError
    case generic
    case noConnection
    case urlRequestNil
    case jsonDecodeError
    
    init(httpStatusCode: Int?) {
        switch httpStatusCode {
        case HttpStatusCode.noContent.rawValue:
            self = .noContent
        case HttpStatusCode.unauthorized.rawValue:
            self = .unauthorized
        case HttpStatusCode.badGateway.rawValue:
            self = .badRequest
        case HttpStatusCode.notFound.rawValue:
            self = .notFound
        case HttpStatusCode.forbidden.rawValue:
            self = .forbidden
        default:
            self = .unknow
        }
    }
    
    var message: String {
        switch self {
        case .noContent:
            return "No content found on server."
        case .unauthorized:
            return "User not authorized"
        case .badRequest:
            return "Bad request error!"
        case .notFound:
            return "Resource not found"
        case .forbidden:
            return "Forbidden access"
        default:
            return "Unknow error"
        }
    }
}

struct NetworkResponse{
    let httpStatusCode: HttpStatusCode?
    let data: Data?
}

struct NetworkError {
    let errorCode: NetworkErrorCode?
    let error: Error?
}
