//
//  TestLogin.swift
//  TestLogin
//
//  Created by huy on 2023/07/02.
//

import XCTest
@testable import MVVM_UnitTest

class LoginViewModelTests: XCTestCase {
    var loginUser: LoginUser!
    var loginUserViewModel: LoginUserViewmodel!
    var networkClientMock: NetworkClientMock!
    var loginViewModelDelegateMock: LoginViewModelDelegateMock!
    var loginRepository: LoginRepository!
    var loginRequest: LoginRequest!
    
    override func setUp() {
        self.loginUser = LoginUser(username: "PhamQuangHuy", 
                                   password: "1236789")
        self.loginRequest = LoginRequest()
        self.loginRequest.params = [:]
        
        self.networkClientMock = NetworkClientMock()
        self.loginViewModelDelegateMock = LoginViewModelDelegateMock()
        self.loginRepository = LoginRepository(networkClient: networkClientMock,
                                               loginRequest: self.loginRequest)
        self.loginUserViewModel = LoginUserViewmodel(delegate: self.loginViewModelDelegateMock,
                                                     loginUser: self.loginUser,
                                                     loginRepository: self.loginRepository)
    }
    
    override func tearDown() {
        self.loginUserViewModel = nil
    }
    
    func testUserName_ShouldReturnInitValue() {
        XCTAssertEqual(loginUserViewModel.username, "PhamQuangHuy")
    }
    
    func testpassword_ShouldReturnInitValue() {
        XCTAssertEqual(loginUserViewModel.password, "1236789")
    }
    
    func testProtectedUserName_ShouldReturnCorrectValue() {
        // input PhamQuangHuy
        // output *********Huy
        XCTAssertEqual(loginUserViewModel.protectedUsername, "*********Huy")
    }
    
    func testUpdateUsername_InputNewUsername_UsernameIsUpdated() {
        loginUserViewModel.updateUsername("PhamQuangHuy2")
        XCTAssertEqual(loginUserViewModel.username, "PhamQuangHuy2")
    }
    
    func testUpdatePassword_InputNewPassword_PasswordIsUpdated() {
        loginUserViewModel.updatePassword("abcdefghijk")
        XCTAssertEqual(loginUserViewModel.password, "abcdefghijk")
    }
    
    func testValidate_UsernameOrPasswordIsNil_ShouldReturnErrorMessage() {
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
    
    func testValidate_UsernamePasswordNormal_ShouldReturnTrue() {
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
    
    func testValidate_UsernamePasswordIsShort_ShouldReturnFalse() {
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
    
    func testLoginWith_NormalUser_ShouldSuccess() {
        let myExpectation = expectation(description: "Expected the login success with normal user.")
        let dataLoginUser = networkClientMock.loadData("loginUser.json")
        let networkResponse = NetworkResponse(httpStatusCode: .success, data: dataLoginUser)
        
        self.loginViewModelDelegateMock.expectation = myExpectation
        self.networkClientMock.result = Result(value: networkResponse)
        self.loginUserViewModel.loginWith("user", and: "password")
        
        self.wait(for: [myExpectation], timeout: 5.0)
    }
}
