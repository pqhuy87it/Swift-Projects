
import UIKit

public typealias JSONDictionary = [String: Any]

struct APIConstant {
    static let domainUrlStr = "https://test.com"
    static let contextPath = "/path/v1"
    static var contentTypeDefault = "application/x-www-form-URLencoded"
    static var contentTypeJson = "application/json; charset=UTF-8"
    static var timeoutDefault: Double = 30.0
    static var retryCountDefault = 1
    static var cacheControlDefault = "private,no-store,no-cache,must-revalidate"
    static var pragmaDefault = "no-cache"
    static var connectionDefault = "Keep-Alive"
}
