//
//  User.swift
//  MVVM-Delegation
//
//  Created by huy on 2023/06/25.
//

import Foundation

class User: Codable {
    var name: String
    var email: String
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}

extension User {
    func map() -> User {
        return User(name: self.name, email: self.email)
    }
}
