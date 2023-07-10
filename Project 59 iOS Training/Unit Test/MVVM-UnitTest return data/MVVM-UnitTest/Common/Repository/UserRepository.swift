//
//  UserRepository.swift
//  MVVM-UnitTest
//
//  Created by huy on 2023/07/01.
//

import Foundation

class UserRepository {
    
    var networkClient: NetworkClient
    var userRequest: UserRequest
    
    init(networkClient: NetworkClient, userRequest: UserRequest) {
        self.networkClient = networkClient
        self.userRequest = userRequest
    }
    
    func fetchUsers(completion: @escaping ((Result<NetworkResponse>) -> Void)) {
        self.networkClient.execute(self.userRequest) { result in
            completion(result)
        }
    }
}
