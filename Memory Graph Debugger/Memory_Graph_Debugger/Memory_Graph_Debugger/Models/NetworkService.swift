//
//  NetworkService.swift
//  Memory_Graph_Debugger
//
//  Created by huy on 2026/03/24.
//

import Foundation


class NetworkService {
    // 🐛 BUG: delegate STRONG → retain cycle với ViewController
    var delegate: NetworkServiceDelegate? // Thiếu `weak`
    
    var cachedData: [String] = []
    
    func fetchUsers() {
        // Giả lập network call
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [self] in
            self.cachedData = (1...1000).map { "User \($0)" }
            DispatchQueue.main.async {
                self.delegate?.didFetchData(self.cachedData)
            }
        }
    }
    
    deinit { print("🟢 NetworkService deinit") }
}
