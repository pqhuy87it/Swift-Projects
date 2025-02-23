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
    case paymentRequired        = 402
    case forbidden              = 403
    case notFound               = 404
    case methodNotAllowed       = 405
    case notAcceptable          = 406
    case proxyAuthenRequired    = 407
    
    //5xx Server errors
    case internalServerError    = 500
    case notImplemented         = 501
    case badGateway             = 502
    case serviceUnavailable     = 503
    case gatewayTimeout         = 504
    
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
