//
//  UserViewModel.swift
//  MVVM-UnitTest
//
//  Created by huy on 2023/07/01.
//

import Foundation

enum LoginErrorType {
    case useramePasswordNil
    case usernameShort
    case passwordShort
}

enum LoginValidationState {
  case Valid
  case Invalid(ValidationError)
}

struct ValidationError {
    var errorType: LoginErrorType
    var errorMessage: String
    
    init(errorType: LoginErrorType, errorMessage: String) {
        self.errorType = errorType
        self.errorMessage = errorMessage
    }
}

class LoginUserViewmodel {
    weak var delegate: LoginViewModelDelegate?
    
    private var user = LoginUser()
    private let minUsernameLength = 4
    private let minPasswordLength = 5
    
    var username: String {
      return user.username
    }

    var password: String {
      return user.password
    }
    
    var protectedUsername: String {
      let characters = username

      if characters.count >= minUsernameLength {
        var displayName = [Character]()
        for (index, character) in characters.enumerated() {
          if index > characters.count - minUsernameLength {
            displayName.append(character)
          } else {
            displayName.append("*")
          }
        }
        return String(displayName)
      }

      return username
    }
    
    init(delegate: LoginViewModelDelegate? = nil, loginUser: LoginUser = LoginUser()) {
        self.user = loginUser
        self.delegate = delegate
    }
    
    // MARK: Public Methods
    
    func updateUsername(_ username: String) {
      user.username = username
    }

    func updatePassword(_ password: String) {
      user.password = password
    }
    
    func validate(_ username: String?, and password: String?) -> LoginValidationState {
        guard let username = username, let password = password else {
            let validationError = ValidationError(errorType: .useramePasswordNil,
                                                  errorMessage: GlobalConstants.UsernamePasswordNilMessage)
          return .Invalid(validationError)
        }
        
      if username.isEmpty || password.isEmpty {
          let validationError = ValidationError(errorType: .useramePasswordNil,
                                                errorMessage: GlobalConstants.UsernamePasswordNilMessage)
        return .Invalid(validationError)
      }

      if username.count < minUsernameLength {
          let validationError = ValidationError(errorType: .usernameShort,
                                                errorMessage: String(format: GlobalConstants.UsernamePasswordNilMessage,
                                                                     arguments: [self.minUsernameLength]))
        return .Invalid(validationError)
      }

      if password.count < minPasswordLength {
          let validationError = ValidationError(errorType: .passwordShort,
                                                errorMessage: String(format: GlobalConstants.PasswordLeghtShortMessage,
                                                                     arguments: [self.minPasswordLength]))
        return .Invalid(validationError)
      }

      return .Valid
    }
    
    func loginWith(_ username: String, and password: String) {
        
    }
}
