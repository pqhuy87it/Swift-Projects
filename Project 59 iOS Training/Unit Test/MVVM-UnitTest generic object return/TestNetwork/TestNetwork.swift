//
//  TestNetwork.swift
//  TestNetwork
//
//  Created by huy on 2023/07/02.
//

import XCTest
@testable import MVVM_UnitTest

final class TestNetwork: XCTestCase {
    
    private(set) var didComplete = false
    
    /// Do something asynchronous and set `didComplete` to true when finished.
    func doSomethingAsynchronous(_ queue: DispatchQueue = DispatchQueue(label: "some queue")) {
        queue.async { [weak self] in
            sleep(5)
            self?.didComplete = true
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testGetUserViewModel() {
        // Create our test queue
            let queue = DispatchQueue(label: "test-queue")
        
        let networkClientMock = NetworkClientMock<User>()
        let userMockData = networkClientMock.load("user.json")
        let networkResponse = NetworkResponse(httpStatusCode: nil,
                                              objects: userMockData)
        let result = Result(value: networkResponse)
        
        networkClientMock.result = result
        
        let userRepository = UserRepository(networkClient: networkClientMock)
        
        let listUserViewModel = ListUserViewModel(getUserRepository: userRepository)
        listUserViewModel.loadData()
        
//        self.doSomethingAsynchronous(queue)
        sleep(5)
        
        XCTAssertEqual(listUserViewModel.getUserCount(), 1)
    }
}
