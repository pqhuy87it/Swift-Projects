import XCTest

class ParameterizedTestBase: ProjectBaseTest {
    typealias TestData = Any
    
    /// Create testcases
    class func createTestCases() -> [ParameterizedTestBase] {
        fatalError("""
           Override this function like this
           class override func createTestCases() -> [ParameterizedTestBase] {
               return testInvocations.map { YouSubClassTest(invocation: $0) }
           }
           """)
    }
    
    /// Test data list
    class var testDatas: [TestData] {
        fatalError("Override this variable to create test cases")
    }
    
    class func setTestData(to testcase: ParameterizedTestBase,
                           with testData: TestData) {
        fatalError("Override this function to cast and set test data")
    }
    
    /// Make TestSuite
    override class var defaultTestSuite: XCTestSuite {
        let testSuite = XCTestSuite(name: NSStringFromClass(self))
        guard self != ParameterizedTestBase.self else {
            return testSuite
        }
        for testData in self.testDatas {
            let testCases = createTestCases()
            for testCase in testCases {
                setTestData(to: testCase, with: testData)
                testSuite.addTest(testCase)
            }
        }
        return testSuite
    }
}
