//
//  LoginViewModelDelegate.swift
//  MVVM-UnitTest
//
//  Created by huy on 2023/07/01.
//

import Foundation

protocol LoginViewModelDelegate: ViewModelDelegate {
    func prepareForLogin()
    func loginSuccessWith(_ user: LoginUser)
    func loginFailWith(_ error: Error)
}
