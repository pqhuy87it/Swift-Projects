//
//  NetworkClientMock.swift
//  MVVM-UnitTest
//
//  Created by huy on 2023/07/02.
//

import Foundation

class NetworkManagerMock<T: Codable>: NetworkManager {
    
    var networkResult: NetworkResult<NetworkResponse<T>>?
    
    func loadData(_ filename: String) -> Data {
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
    
//    override func execute<U: Codable>(_ request: any NetworkRequest) async throws -> NetworkResult<NetworkResponse<U>>? {
//        if let networkResult = self.networkResult {
//            return networkResult
//        }
//    }
}
