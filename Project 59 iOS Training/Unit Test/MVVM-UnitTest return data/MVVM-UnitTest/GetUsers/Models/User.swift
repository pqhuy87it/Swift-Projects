//
//  User.swift
//  MVVM-UnitTest
//
//  Created by huy on 2023/07/02.
//

import Foundation

class User: Codable {
    var name: String
    var email: String
    var address: Address?
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}

class Address: Codable {
    
}
