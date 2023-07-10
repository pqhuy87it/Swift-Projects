//
//  UserRepository.swift
//  MVVM-UnitTest
//
//  Created by huy on 2023/07/01.
//

import Foundation

class UserRepository {
//    typealias CompletionHandlerClosureType<T> = (Result<NetworkResponse<T>>) -> Void
    
    var networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func fetchUsers(completion: @escaping ((Result<NetworkResponse<[User]>>) -> Void)) {
        let getUserRequest = UserRequest()
        networkClient.execute(getUserRequest) { result in
            completion(result)
        }
    }
}
