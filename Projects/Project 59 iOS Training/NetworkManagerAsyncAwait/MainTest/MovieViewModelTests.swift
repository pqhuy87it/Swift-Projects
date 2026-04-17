//
//  MovieViewModelTests.swift
//  MainTest
//
//  Created by Huy Pham on 2024/10/31.
//

import Foundation
import XCTest
@testable import NetworkManagerAsyncAwait

@MainActor
final class MovieViewModelTests: XCTestCase {
    
    var networkmanager: NetworkManager!
    var movieViewModel: MovieViewModel!
    var movieViewModelDelegateMock: MovieViewModelDelegateMock!
    var movieRepository: MovieRepository!
    var urlSessionMockClass: URLSessionMockClass!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        self.movieViewModelDelegateMock = MovieViewModelDelegateMock()
        self.urlSessionMockClass = URLSessionMockClass()
        
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testGetMovie_Normal_Success() {
        let myExpectation = self.expectation(description: "Get movie")
        let data = DataHelper.load("Movies.json")
    
        self.urlSessionMockClass.data = data
        self.urlSessionMockClass.statusCode = 200
        
        self.movieViewModelDelegateMock.expectation = myExpectation
        self.networkmanager = NetworkManager(urlSession: self.urlSessionMockClass)
        self.movieRepository = MovieRepository(networkManager: self.networkmanager)
        self.movieViewModel = MovieViewModel(delegate: self.movieViewModelDelegateMock,
                                             movieRepository: self.movieRepository)
        
        self.movieViewModel.getDataMovies()
        
        self.wait(for: [myExpectation], timeout: 5.0)
    }
}
