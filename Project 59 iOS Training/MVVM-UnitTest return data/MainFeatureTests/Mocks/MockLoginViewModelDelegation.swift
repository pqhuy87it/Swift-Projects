//
//  MockLoginViewModelDelegation.swift
//  MainFeaturesTests
//
//  Created by Huy Pham on 2024/04/22.
//

import Foundation
import XCTest
@testable import MVVM_UnitTest

class LoginViewModelDelegateMock: LoginViewModelDelegate {
    
    var expectation: XCTestExpectation?
    
    func prepareForLogin() {
        // Todo
    }
    
    func loginSuccessWith(_ user: LoginUser?) {
        self.expectation?.fulfill()
    }
    
    func loginFailWith(_ error: NetworkError) {
        // Todo
    }
    
    
}
