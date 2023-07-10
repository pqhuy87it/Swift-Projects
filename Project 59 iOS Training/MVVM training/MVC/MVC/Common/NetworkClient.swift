//
//  NetworkClient.swift
//  MVVM-Delegation
//
//  Created by huy on 2023/06/25.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

class NetworkClient {
    
    static func get<T: Codable>(url: URL, completion: @escaping (Result<T>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            if let error = responseError {
                completion(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let objects = try decoder.decode(T.self, from: jsonData)
                    let result: Result<T> = Result.success(objects)
                    completion(result)
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
}
