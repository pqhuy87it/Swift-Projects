import Foundation

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
        case NetworkStatusCode.noContent.rawValue:
            self = .noContent
        case NetworkStatusCode.unauthorized.rawValue:
            self = .unauthorized
        case NetworkStatusCode.badGateway.rawValue:
            self = .badRequest
        case NetworkStatusCode.notFound.rawValue:
            self = .notFound
        case NetworkStatusCode.forbidden.rawValue:
            self = .forbidden
        case NetworkStatusCode.notFound.rawValue:
            self = .nilData
        case NetworkStatusCode.methodNotAllowed.rawValue:
            self = .badRequest
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
            return "Resource not found."
        case .forbidden:
            return "Forbidden access."
        default:
            return "Unknow error."
        }
    }
}
