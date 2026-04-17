//
//  UITestingUITests.swift
//  UITestingUITests
//
//  Created by Huy Pham on 2024/11/06.
//

import XCTest

final class UITestingUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var firstNameTextField: XCUIElement!
    private var lastNameTextField: XCUIElement!
    private var emailTextField: XCUIElement!
    private var passwordTextField: XCUIElement!
    private var repeatPasswordTextField: XCUIElement!
    private var signUpButton: XCUIElement!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launch()
        
        firstNameTextField = app.textFields["firstNameTextField"]
        lastNameTextField = app.textFields["lastNameTextField"]
        emailTextField = app.textFields["emailTextField"]
        passwordTextField = app.textFields["passwordTextField"]
        repeatPasswordTextField = app.textFields["repeatPasswordTextField"]
        signUpButton = app.buttons["signUpButton"]

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
        firstNameTextField = nil
        lastNameTextField = nil
        emailTextField = nil
        passwordTextField = nil
        repeatPasswordTextField = nil
        signUpButton = nil
        
        try super.tearDownWithError()
    }

    func testSignupViewController_WhenViewLoaded_RequiredUIElementesAreEnabled() {
        XCTAssertTrue(firstNameTextField.isEnabled, "First name UITextField is not enable for user interactions")
        XCTAssertTrue(lastNameTextField.isEnabled, "Last name UITextField is not enable for user interactions")
        XCTAssertTrue(emailTextField.isEnabled, "Email UITextField is not enable for user interactions")
        XCTAssertTrue(passwordTextField.isEnabled, "Password UITextField is not enable for user interactions")
        XCTAssertTrue(repeatPasswordTextField.isEnabled, "Repeat password UITextField is not enable for user interactions")
        XCTAssertTrue(signUpButton.isEnabled, "Sign up button is not enable for user interactions")
    }
    
    func testViewController_WhenInvalidFormSubmitted_PresentsErrorAlertDialog() {
        firstNameTextField.tap()
        firstNameTextField.typeText("invalid")
        
        lastNameTextField.tap()
        lastNameTextField.typeText("invalid")
        
        emailTextField.tap()
        emailTextField.typeText("invalid")
        
        passwordTextField.tap()
        passwordTextField.typeText("invalid")
        
        repeatPasswordTextField.tap()
        repeatPasswordTextField.typeText("invalid")
        
        signUpButton.tap()
        
        XCTAssertTrue(app.alerts["errorAlertDialog"].waitForExistence(timeout: 1), "Alert dialog is not presented")
    }
    
    func testViewController_WhenValidFormSubmitted_PresentsSuccessAlertDialog() {
        firstNameTextField.tap()
        firstNameTextField.typeText("Huy")
        
        lastNameTextField.tap()
        lastNameTextField.typeText("Pham")
        
        emailTextField.tap()
        emailTextField.typeText("huypq22@fpt.com")
        
        passwordTextField.tap()
        passwordTextField.typeText("123456789")
        
        repeatPasswordTextField.tap()
        repeatPasswordTextField.typeText("123456789")
        
        signUpButton.tap()
        
        XCTAssertTrue(app.alerts["successAlertDialog"].waitForExistence(timeout: 3), "Alert dialog is not presented")
    }
}
