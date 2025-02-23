import Foundation
import UIKit

class NetworkManager {
    let urlSession: URLSession
    
    init() {
        self.urlSession = URLSession.shared
    }
    
    init(urlSession: URLSession?) {
        if let urlSession = urlSession {
            self.urlSession = urlSession
        } else {
            self.urlSession = URLSession.shared
        }
    }
    
    func execute<T: Codable>(_ request: NetworkRequest) async throws -> NetworkResult<NetworkResponse<T>>? {
        let urlRequest = request.buildURLRequest()
        async let (data, response) = self.urlSession.data(for: urlRequest)
        
        guard let response = try await response as? HTTPURLResponse else {
            let networkError = NetworkError(errorCode: NetworkErrorCode.nilData,
                                            error: nil)
            return NetworkResult(error: networkError)
        }
        
        let statusCode = response.statusCode
        let decoder = JSONDecoder()
        let httpStatusCode = NetworkStatusCode(statusCode)
        
        if case(200..<300) = statusCode {
            do {
                let objects = try decoder.decode(T.self, from: try await data)
                let response = try await NetworkResponse<T>(httpStatusCode: httpStatusCode,
                                                            objects: objects,
                                                            data: data)
                return NetworkResult(value: response)
            } catch {
                let networkError = NetworkError.init(errorCode: NetworkErrorCode.jsonDecodeError,
                                                     error: error)
                return NetworkResult(error: networkError)
            }
        } else {
            let networkErrorCode = NetworkErrorCode(httpStatusCode: statusCode)
            let networkError = NetworkError(errorCode: networkErrorCode,
                                            error: nil)
            return NetworkResult(error: networkError)
        }
    }
}
