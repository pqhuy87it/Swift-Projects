
import UIKit

protocol APIRequest {
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
}

extension APIRequest {
    var baseURL: URL {
        return URL(string: APIManager.baseURL)!
    }
    
    var contentType: String {
        return APIConstant.contentTypeDefault
    }
    
    var connection: String {
        return APIConstant.connectionDefault
    }
    
    var timeoutInterval: Double {
        return APIConstant.timeoutDefault
    }
    
    var apiRetryNo: Int {
        return APIConstant.retryCountDefault
    }
    
    var cacheControl: String {
        return APIConstant.cacheControlDefault
    }
    
    var pragma: String {
        return APIConstant.pragmaDefault
    }
    
    var host: String {
        let urlComponent = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        return (urlComponent?.host ?? "") + ":443"
    }
    
    var userIdentify: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) { ptr in
                String.init(validatingUTF8: ptr)
            }
        }
        
        let osEnvironment = "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)"
        let companyName = "Apple"
        let deviceName = modelCode ?? ""
        let osLocalLanguage = NSLocale.preferredLanguages.first ?? ""
        let deviceIdentifier = UIDevice.current.identifierForVendor?.uuidString ?? ""
        let array: [String] = [osEnvironment, companyName, deviceName, osLocalLanguage, deviceIdentifier]
        return array.joined(separator: "|")
    }
    
    func buildURLRequest() -> URLRequest {
        var url: URL = baseURL.appendingPathComponent(path)
        
        if method == .get, let queryItems = params {
            url = url.addQueryItemsParcentEncoding(queryItems) ?? url
        }
        logD(url, logLevel: .info)

        var urlRequest = URLRequest(url: url)
        
        urlRequest.timeoutInterval = timeoutInterval
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue(contentType, forHTTPHeaderField: JSONKey.ContentType)
        urlRequest.addValue(connection, forHTTPHeaderField: JSONKey.Connection)
        urlRequest.setValue(cacheControl, forHTTPHeaderField: JSONKey.CacheControl)
        urlRequest.setValue(pragma, forHTTPHeaderField: JSONKey.Prama)
        #if ATTEMPT
        #else
        urlRequest.setValue(userIdentify, forHTTPHeaderField: JSONKey.XUserIdentify)
        urlRequest.setValue(host, forHTTPHeaderField: JSONKey.Host)
        #endif
        
        if let accessToken = accessToken {
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: JSONKey.Authorization)
        }
        
        if let headers = headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if method == .post, let body = params {
            urlRequest.addBodyParcentEncoding(body)
            logD(String(data: urlRequest.httpBody!, encoding: .utf8)!)
        }
        logD(urlRequest.allHTTPHeaderFields)
        
        return urlRequest
    }
    
    func buildBrowserURL() -> URL {
        var url: URL = baseURL.appendingPathComponent(path)
        
        if method == .get, let queryItems = params {
            url = url.addQueryItemsParcentEncoding(queryItems) ?? url
            logD(url, logLevel: .info)
        }
        return url
    }
}

extension URLRequest {
    mutating func addBodyParcentEncoding(_ parameters: [String: Any?]) {
        
        let parameterArray = parameters.map { (arg) -> String in
            return "\(arg.key)=\(percentEscapeString(arg.value as? String ?? ""))"
        }
        
        httpBody = parameterArray.joined(separator: "&").data(using: String.Encoding.utf8)
    }
}

extension URL {
    mutating func addQueryItemsParcentEncoding(_ queryItems: [String: Any?]) -> URL? {
        guard var components = URLComponents(url: self,
                                             resolvingAgainstBaseURL: nil != self.baseURL) else {
                                                return nil
        }
        let queryArray = queryItems.map { (arg) -> String in
            return "\(arg.key)=\(percentEscapeString(arg.value as? String ?? ""))"
        }
        
        components.percentEncodedQuery = queryArray.joined(separator: "&")
        
        return components.url
    }
}

fileprivate func percentEscapeString(_ string: String) -> String {
    var characterSet = CharacterSet.alphanumerics
    characterSet.insert(charactersIn: "-._*")
    
    return string
        .addingPercentEncoding(withAllowedCharacters: characterSet)!
}
