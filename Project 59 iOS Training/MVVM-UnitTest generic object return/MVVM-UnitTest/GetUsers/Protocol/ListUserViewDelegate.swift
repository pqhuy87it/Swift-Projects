//
//  ListUserViewDelegate.swift
//  MVVM-UnitTest
//
//  Created by huy on 2023/07/02.
//

import Foundation

protocol ListUserViewDelegate: AnyObject {
    func prepareForGetData()
    func getListUserSuccess()
    func didFailWithError()
}
