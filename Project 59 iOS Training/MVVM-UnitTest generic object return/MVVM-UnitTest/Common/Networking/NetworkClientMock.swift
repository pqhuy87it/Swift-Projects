//
//  NetworkClientMock.swift
//  MVVM-UnitTest
//
//  Created by huy on 2023/07/02.
//

import Foundation

class NetworkClientMock<T: Codable>: NetworkClient {
    
    var result: NetworkResult<NetworkResponse<T>>?
    var object: [User] = []
    
    func load(_ filename: String) -> T {
        let data: Data
        let returnObject: T
        let decoder = JSONDecoder()
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
            returnObject = try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        return returnObject
    }
    
    override func execute<U: Codable>(_ request: NetworkRequest, completionHandler: @escaping (NetworkResult<NetworkResponse<U>>) -> Void) {
        
    }
}
