//
//  TestingViewcontrollerNavigationTests.swift
//  TestingViewcontrollerNavigationTests
//
//  Created by Huy Pham on 2024/11/05.
//

import XCTest
@testable import TestingViewcontrollerNavigation

final class TestingViewcontrollerNavigationTests: XCTestCase {
    
    var sut: ViewController!
    var navigationController: UINavigationController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        sut = storyboard.instantiateViewController(identifier: "ViewController") as? ViewController
        
        sut.loadViewIfNeeded()
        navigationController = UINavigationController(rootViewController: sut)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        navigationController = nil
    }

    func testNextViewButton_WhenTapped_SecondViewControllerShouldBePushed() {
        let prediction = NSPredicate { input, _ in
            return (input as? UINavigationController)?.topViewController is SecondViewController
        }
        
        expectation(for: prediction, evaluatedWith: navigationController)
        
        sut.nextViewButton.sendActions(for: .touchUpInside)
        
        waitForExpectations(timeout: 5)
    }
    
    func testNextViewButton_WhenTapped_SecondViewcontrollerIsPushed() {
        sut.nextViewButton.sendActions(for: .touchUpInside)
        
        RunLoop.current.run(until: Date())
        
        guard let _ = navigationController.topViewController as? SecondViewController else {
            XCTFail("SecondViewController should be pushed")
            return
        }
    }
    
    func testNextViewButton_WhenTapped_SecondViewControllerIsPushed_WithSpyWay() {
        let spyNavigationController = SpyNavigationController(rootViewController: sut)
        
        sut.nextViewButton.sendActions(for: .touchUpInside)
        
        guard let _ = spyNavigationController.pushedViewcontroller as? SecondViewController else {
            XCTFail("SecondViewController should be pushed")
            return
        }
    }
}
