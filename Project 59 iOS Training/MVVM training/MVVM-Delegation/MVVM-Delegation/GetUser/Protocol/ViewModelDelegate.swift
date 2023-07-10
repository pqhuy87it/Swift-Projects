//
//  ViewModelProtocol.swift
//  MVVM-Delegation
//
//  Created by huy on 2023/06/25.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func willLoadData()
    func didLoadData()
    func didLoadDataFailedWith(_ error: Error?)
}
