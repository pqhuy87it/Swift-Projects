//
//  MovieViewModelDelegateMock.swift
//  MainTest
//
//  Created by Huy Pham on 2024/10/31.
//

import Foundation
import XCTest
@testable import NetworkManagerAsyncAwait

class MovieViewModelDelegateMock: MovieViewModelDelegate {
    var expectation: XCTestExpectation?
    
    func getDataMoviesSuccess() {
        self.expectation?.fulfill()
    }
    
    func handleGetMoviesFailedWith(_ error: NetworkManagerAsyncAwait.NetworkError) {
        
    }
    
    func prepareForGetData() {
        
    }
    
    
}
