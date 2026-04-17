//
//  LoginRequest.swift
//  MVVM-UnitTest
//
//  Created by Huy Pham on 2024/04/22.
//

import Foundation

struct LoginRequest: NetworkRequest {
    var path: String {
        return "/login"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]?
    
    var params: [String : Any?]?
    
    var accessToken: String?
    
    var port: String?
    
    
}
