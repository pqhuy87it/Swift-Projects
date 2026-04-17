//
//  UserRepository.swift
//  MVVM-Delegation
//
//  Created by huy on 2023/06/25.
//

import Foundation

class UserRepository {
    enum Constant {
        static let URLString = "https://jsonplaceholder.typicode.com/users"
    }
    
    func fetchUsers(completion: @escaping (_ result: Result<[User]>) -> Void) {
        if let url = URL(string: Constant.URLString) {
            NetworkClient.get(url: url, completion: { result in
                completion(result)
            })
        }
    }
}
