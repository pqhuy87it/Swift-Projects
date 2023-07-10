//
//  TestLogin.swift
//  TestLogin
//
//  Created by huy on 2023/07/02.
//

import XCTest
@testable import MVVM_UnitTest

final class LoginViewModelTests: XCTestCase {

    var loginUserViewModel: LoginUserViewmodel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        let loginUser = LoginUser(username: "PhamQuangHuy", password: "1236789")
        self.loginUserViewModel = LoginUserViewmodel(loginUser: loginUser)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.loginUserViewModel = nil
        try super.tearDownWithError()
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testUserName() {
        XCTAssertEqual(loginUserViewModel.username, "PhamQuangHuy")
    }
    
    func testpassword() {
        XCTAssertEqual(loginUserViewModel.password, "1236789")
    }
    
    func testProtectedUserName() {
        // input PhamQuangHuy
        // output *********Huy
        XCTAssertEqual(loginUserViewModel.protectedUsername, "*********Huy")
    }
    
    func testUpdateUsername() {
        loginUserViewModel.updateUsername("PhamQuangHuy2")
        XCTAssertEqual(loginUserViewModel.username, "PhamQuangHuy2")
    }
    
    func testUpdatePassword() {
        loginUserViewModel.updatePassword("abcdefghijk")
        XCTAssertEqual(loginUserViewModel.password, "abcdefghijk")
    }
    
    func testValidateUsernameNil() {
        var username: String?
        var password: String?
        
        username = nil
        password = "123456"
        let validation = loginUserViewModel.validate(username, and: password)
        
        if case .Invalid(let validationError) = validation {
            XCTAssertEqual(validationError.errorMessage, GlobalConstants.UsernamePasswordNilMessage)
        } else {
            XCTAssert(false)
        }
        
        username = "username"
        password = nil
        let validation1 = loginUserViewModel.validate(username, and: password)
        
        if case .Invalid(let validationError) = validation1 {
            XCTAssertEqual(validationError.errorMessage, GlobalConstants.UsernamePasswordNilMessage)
        } else {
            XCTAssert(false)
        }
        
        username = ""
        password = ""
        let validation3 = loginUserViewModel.validate(username, and: password)
        
        if case .Invalid(let validationError) = validation3 {
            XCTAssertEqual(validationError.errorMessage, GlobalConstants.UsernamePasswordNilMessage)
        }
        
        username = "1"
        password = ""
        
        username = ""
        password = "1"
    }
    
    func testValidateUsernamePasswordNotNil() {
        var username: String?
        var password: String?
        
        username = "username"
        password = "password"
        let validation = loginUserViewModel.validate(username, and: password)
        
        if case .Valid = validation {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testUsernamePasswordShort() {
        var username: String?
        var password: String?
        
        username = "abc"
        password = "123"
        let validation = loginUserViewModel.validate(username, and: password)
        let errorMessage = loginUserViewModel.getErrorMessageUsernameShort()
        
        if case .Invalid(let validationError) = validation {
            XCTAssertEqual(validationError.errorMessage, errorMessage)
        } else {
            XCTAssert(false)
        }
        
        username = "abcdef"
        password = "123"
        let validation1 = loginUserViewModel.validate(username, and: password)
        let passwordErrorMessage = loginUserViewModel.getErrorPasswordShort()
        
        if case .Invalid(let validationError) = validation1 {
            XCTAssertEqual(validationError.errorMessage, passwordErrorMessage)
        } else {
            XCTAssert(false)
        }
        
        username = "abcdef"
        password = "123456"
        let validation2 = loginUserViewModel.validate(username, and: password)
        
        if case .Valid = validation2 {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
}
