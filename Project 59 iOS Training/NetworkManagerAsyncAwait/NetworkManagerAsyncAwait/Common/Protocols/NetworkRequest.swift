import Foundation

enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}

protocol NetworkRequest {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var contentType: String { get }
    var headers: [String: String]? { get set }
    var params: [String: Any?]? { get set }
    var accessToken: String? { get set }
    var connection: String { get }
    var timeoutInterval: Double { get }
    var apiRetryNo: Int { get }
    var port: String? { get set }
}

extension NetworkRequest {
    var baseURL: URL {
        return URL(string: NetworkConstants.baseURL)!
    }
    
    var contentType: String {
        return NetworkConstants.contentTypeDefault
    }
    
    var connection: String {
        return NetworkConstants.connectionDefault
    }
    
    var timeoutInterval: Double {
        return NetworkConstants.timeoutDefault
    }
    
    var apiRetryNo: Int {
        return NetworkConstants.retryCountDefault
    }
    
    var cacheControl: String {
        return NetworkConstants.cacheControlDefault
    }
    
    var pragma: String {
        return NetworkConstants.pragmaDefault
    }
    
    var host: String {
        if let port = self.port {
            let urlComponent = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            return (urlComponent?.host ?? "") + port
        } else {
            return URLComponents(url: baseURL, resolvingAgainstBaseURL: true)?.host ?? ""
        }
    }
    
    func buildURLRequest() -> URLRequest {
        var url: URL = baseURL.appendingPathComponent(path)
        
        if method == .get, let queryItems = params {
            url = url.addQueryItemsParcentEncoding(queryItems) ?? url
        }

        var urlRequest = URLRequest(url: url)
        
        urlRequest.timeoutInterval = timeoutInterval
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue(contentType, forHTTPHeaderField: NetworkConstants.ContentType)
        urlRequest.addValue(connection, forHTTPHeaderField: NetworkConstants.Connection)
        urlRequest.setValue(cacheControl, forHTTPHeaderField: NetworkConstants.CacheControl)
        urlRequest.setValue(pragma, forHTTPHeaderField: NetworkConstants.Prama)
        urlRequest.setValue(host, forHTTPHeaderField: NetworkConstants.Host)
        
        if let headers = headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if method == .post, let body = params {
            urlRequest.addBodyParcentEncoding(body)
        }
        
        return urlRequest
    }
    
    func buildBrowserURL() -> URL {
        var url: URL = baseURL.appendingPathComponent(path)
        
        if method == .get, let queryItems = params {
            url = url.addQueryItemsParcentEncoding(queryItems) ?? url
        }
        
        return url
    }
}
