import Foundation

struct NetworkConstants {
    static let baseURL = "https://api.themoviedb.org/3/movie"
    static var contentTypeDefault = "application/x-www-form-URLencoded"
    static var contentTypeJson = "application/json; charset=UTF-8"
    static var timeoutDefault: Double = 30.0
    static var retryCountDefault = 1
    static var cacheControlDefault = "private,no-store,no-cache,must-revalidate"
    static var pragmaDefault = "no-cache"
    static var connectionDefault = "Keep-Alive"
    static let Connection = "Connection"
    static let CacheControl = "Cache-Control"
    static let ContentType = "Content-Type"
    static let ContentLength = "Content-Length"
    static let Prama = "Pragma"
    static let XUserIdentify = "x-user-identify"
    static let Host = "Host"
}
