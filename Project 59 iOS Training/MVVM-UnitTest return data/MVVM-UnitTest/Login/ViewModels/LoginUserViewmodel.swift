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
    
    private var loginUser = LoginUser()
    private let minUsernameLength = 4
    private let minPasswordLength = 5
    
    private var loginRepository: LoginRepository
    
    var username: String {
      return loginUser.username
    }

    var password: String {
      return loginUser.password
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
    
    init(delegate: LoginViewModelDelegate? = nil, loginUser: LoginUser = LoginUser(), loginRepository: LoginRepository) {
        self.loginUser = loginUser
        self.delegate = delegate
        self.loginRepository = loginRepository
    }
    
    // MARK: Public Methods
    
    func updateUsername(_ username: String) {
      loginUser.username = username
    }

    func updatePassword(_ password: String) {
      loginUser.password = password
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
          let errorMessage = getErrorMessageUsernameShort()
          let validationError = ValidationError(errorType: .usernameShort,
                                                errorMessage: errorMessage)
        return .Invalid(validationError)
      }

      if password.count < minPasswordLength {
          let errorMessage = getErrorPasswordShort()
          let validationError = ValidationError(errorType: .passwordShort,
                                                errorMessage: errorMessage)
        return .Invalid(validationError)
      }

      return .Valid
    }
    
    func getErrorMessageUsernameShort() -> String {
        return String(format: GlobalConstants.UsernameLengthShortMessage,
                      arguments: ["\(self.minUsernameLength)"])
    }
    
    func getErrorPasswordShort() -> String {
        return String(format: GlobalConstants.PasswordLeghtShortMessage,
                      arguments: ["\(self.minPasswordLength)"])
    }
    
    func loginWith(_ username: String, and password: String) {
        self.loginRepository.loginWith(username, passWord: password) {[weak self] result in
            switch result {
            case .failure(let error):
                self?.delegate?.loginFailWith(error)
            case .success(_):
                self?.delegate?.loginSuccessWith(self?.loginUser)
            }
        }
    }
}
