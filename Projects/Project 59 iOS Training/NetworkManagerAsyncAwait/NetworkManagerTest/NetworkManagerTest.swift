//
//  NetworkManagerTest.swift
//  NetworkManagerTest
//
//  Created by Huy Pham on 2024/10/28.
//

import Testing
import XCTest
@testable import NetworkManagerAsyncAwait

final class NetworkManagerTest: XCTestCase {
    var urlSessionMockClass: URLSessionMockClass!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        self.urlSessionMockClass = URLSessionMockClass()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testRequest_StatusCode200_Success() async {
        let data = DataHelper.load("Movies.json")
        
        self.urlSessionMockClass.data = data
        self.urlSessionMockClass.statusCode = 200
        
        let networkManager = NetworkManager(urlSession: self.urlSessionMockClass)
        let movieRequest = MovieRequest()
        
        do {
            if let networkResult: NetworkResult<NetworkResponse<MovieResponse>> = try await networkManager.execute(movieRequest) {
                switch networkResult {
                case .success(let response):
                    XCTAssertEqual(response.httpStatusCode?.rawValue, 200)
                case .failure(let error):
                    XCTAssertNotNil(error)
                }
            } else {
                
            }
        } catch {
            
        }
    }
    
    func testRequest_StatusCode400_Failure() async {
        let data = DataHelper.load("Movies.json")
        
        self.urlSessionMockClass.data = data
        self.urlSessionMockClass.statusCode = 400
        
        let networkManager = NetworkManager(urlSession: self.urlSessionMockClass)
        let movieRequest = MovieRequest()
        
        do {
            if let networkResult: NetworkResult<NetworkResponse<MovieResponse>> = try await networkManager.execute(movieRequest) {
                switch networkResult {
                case .success(let response):
                    XCTFail("Expected failure, got success")
                case .failure(let error):
                    XCTAssertEqual(error.errorCode, NetworkErrorCode.badRequest)
                }
            } else {
                
            }
        } catch {
            
        }
    }
    
    func testDecode_InvalidJSON_Failure() async {
        let data = Data()
        
        self.urlSessionMockClass.data = data
        self.urlSessionMockClass.statusCode = 200
        
        let networkManager = NetworkManager(urlSession: self.urlSessionMockClass)
        let movieRequest = MovieRequest()
        
        do {
            if let networkResult: NetworkResult<NetworkResponse<MovieResponse>> = try await networkManager.execute(movieRequest) {
                switch networkResult {
                case .success(let response):
                    XCTFail("Expected failure, got success")
                case .failure(let error):
                    XCTAssertEqual(error.errorCode, NetworkErrorCode.jsonDecodeError)
                }
            } else {
                
            }
        } catch {
            
        }
    }
}
