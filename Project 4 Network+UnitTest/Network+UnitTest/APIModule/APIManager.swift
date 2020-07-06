

import UIKit

class APIManager {
    static var shared: APIManager = APIManager()
    
    public static var baseURL: String = APIConstant.domainUrlStr + APIConstant.contextPath
   
    public static func setBaseUrl(url: String) {
        APIManager.baseURL = url
    }
    
    init() {
        logD("APIManager initialized", logLevel: .info)
    }
    
    func execute(request: APIRequest, completionHandler: @escaping (Result<ResponseObject>) -> Void) {
        let urlRequest = request.buildURLRequest()
        
        // Handle request & retry
        DispatchQueue.global(qos: .default).async {
            for i in 1...request.apiRetryNo {
                let requestSemaphore = DispatchSemaphore(value: 0)
                
                var checkSuccess = false
                
                #if TESTING
                // Bypass Code !!
                let urlSession = URLSession(
                    configuration: URLSessionConfiguration.default,
                    delegate: BypassURLSessionDelegate.shared,
                    delegateQueue: nil)
                #else
                let urlSession = URLSession.shared
                #endif
                
                urlSession.dataTask(with: urlRequest) { (data, response, error) in
                    
                    // 通信終了処理
                    switch(data, response, error) {
                    case(_, _, let error?):
                        logD("error: \(error.localizedDescription)", logLevel: .error)
                        // after retry failed, call completionHandle
                        if i == request.apiRetryNo {
                            logD("Request api \(request.path) failed", logLevel: .error)
                            
                            completionHandler(
                                Result(apiError: ResponseObject(statusCode: nil, data: nil, error: error)))
                        }
                    case(let data?, let response?, _):
                        logD("Raw Data: " + (String(data: data, encoding: .utf8) ?? ""))
                        let status = (response as? HTTPURLResponse)?.statusCode
                        if case(200..<300)? = status {
                            // Success
                            completionHandler(Result(value:
                                ResponseObject(statusCode: HttpStatusCode(statusCode: status), data: data, error: nil)))
                        } else {
                            // Failure
                            completionHandler(Result(apiError:
                                ResponseObject(statusCode: HttpStatusCode(statusCode: status), data: data, error: nil)))
                        }
                        
                        // end loop
                        checkSuccess = true
                    default:
                        fatalError("invalid response combination \(String(describing: data)), \(String(describing: response)), \(String(describing: error))")
                    }
                    // notify call api done
                    requestSemaphore.signal()
                }.resume()
                
                // waiting
                requestSemaphore.wait()
                
                if checkSuccess {
                    // request success
                    break
                } else {
                    logD("Retry api \(request.path) no \(i)", logLevel: .debug)
                }
            }
        }
    }
}

class APIManagerMock: APIManager {
    var result: (Result<ResponseObject>)?
    
    override func execute(request: APIRequest, completionHandler: @escaping ResponseHandler) {
        if let result = self.result {
            completionHandler(result)
        }
    }
    
    func load(_ filename: String) -> Data {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        return data
    }
}

#if TESTING
extension URLRequest {
    static func allowsAnyHTTPSCertificateForHost(host: String) -> Bool {
        return true
    }
}

class BypassURLSessionDelegate: NSObject, URLSessionDelegate {
    static let shared = {
        return BypassURLSessionDelegate()
    }()

    private override init(){}
    
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                let credential = URLCredential(trust: serverTrust)
                completionHandler(.useCredential, credential)
            }
        }
        completionHandler(.performDefaultHandling, nil)
    }
}
#endif
