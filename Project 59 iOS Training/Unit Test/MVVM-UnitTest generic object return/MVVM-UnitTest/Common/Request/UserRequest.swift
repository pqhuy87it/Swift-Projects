//
//  UserRequest.swift
//  MVVM-UnitTest
//
//  Created by huy on 2023/07/01.
//

import Foundation
import UIKit

struct UserRequest: NetworkRequest {
    var path: String {
        return "/users"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]?
    
    var params: [String : Any?]?
    
    var accessToken: String?
    
    var port: String?
}
