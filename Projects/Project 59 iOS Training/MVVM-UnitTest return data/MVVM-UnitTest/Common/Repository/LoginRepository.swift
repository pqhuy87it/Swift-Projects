//
//  LoginRepository.swift
//  MVVM-UnitTest
//
//  Created by Huy Pham on 2024/04/22.
//

import Foundation

class LoginRepository {
    
    var networkClient: NetworkClient
    var loginRequest: LoginRequest
    
    init(networkClient: NetworkClient, loginRequest: LoginRequest) {
        self.networkClient = networkClient
        self.loginRequest = loginRequest
    }
    
    func loginWith(_ userName: String, passWord: String, completion: @escaping ((Result<NetworkResponse>) -> Void)) {
        self.loginRequest.params?["username"] = userName
        self.loginRequest.params?["password"] = passWord
        
        self.networkClient.execute(self.loginRequest) { result in
            completion(result)
        }
    }
}
