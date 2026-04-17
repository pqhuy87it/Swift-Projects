//
//  NetworkClientMock.swift
//  MVVM-UnitTest
//
//  Created by huy on 2023/07/02.
//

import Foundation

class NetworkClientMock: NetworkClient {
    
    var result: Result<NetworkResponse>?
    
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
    
    override func execute(_ request: NetworkRequest, completionHandler: @escaping (Result<NetworkResponse>) -> Void) {
        if let result = self.result {
            completionHandler(result)
        }
    }
}
