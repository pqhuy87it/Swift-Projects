//
//  NetworkResponse.swift
//  MVVM-UnitTest
//
//  Created by huy on 2023/07/01.
//

import Foundation

struct NetworkResponse<U: Codable> {
    let httpStatusCode: NetworkStatusCode?
    let objects: U?
    let data: Data?
}
