
import UIKit

public typealias ResponseHandler = (Result<ResponseObject>) -> Void

internal enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}

public enum HttpStatusCode: Int {
    case ok = 200
    case created = 201
    case accepted = 202
    case noContent = 204
    case errorDomain = 311
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case notAcceptable = 406
    case requestTimeout = 408
    case conflict = 409
    case internalServerError = 500
    case serviceUnavailable = 503
    case cancelled = -999
    case timeOut = -1001
    case cannotFindHost = -1003
    case notConnectedToInternet = -1009
    case uploadDataError = 3000
    case unknow = 9999
    case failedHTML = 8888
    case failedProblemJson = 7777
    
    init?(statusCode: Int?) {
        guard let statusCode = statusCode else {
            return nil
        }
        
        // init
        if let value = HttpStatusCode(rawValue: statusCode) {
            self = value
        } else {
            self = HttpStatusCode.unknow
        }
    }
}
