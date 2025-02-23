import XCTest

extension XCTest {
    /// Step GIVEN
    ///
    /// - Parameters
    ///   - name: Step name
    ///   - actionStep: Action
    func GIVEN(_ name: String, step: () -> Void) {
        runStep("GIVEN \(name)", step)
    }

    /// Step WHEN
    ///
    /// - Parameters
    ///   - name: Step name
    ///   - actionStep: Action
    func WHEN(_ name: String, step: () -> Void) {
        runStep("WHEN \(name)", step)
    }

    /// Step THEN
    ///
    /// - Parameters
    ///   - name: Step name
    ///   - actionStep: Action
    func THEN(_ name: String, step: () -> Void) {
        runStep("THEN \(name)", step)
    }

    /// Step AND
    ///
    /// - Parameters
    ///   - name: Step name
    ///   - actionStep: Action
    func AND(_ name: String, step: () -> Void) {
        runStep("AND \(name)", step)
    }
    
    /// Step base
    ///
    /// - Parameters
    ///   - name: Step name
    ///   - step: Action
    private func runStep(_ name: String, _ actionStep: () -> Void) {
        if Thread.isMainThread {
            step(name, step: actionStep)
        } else {
            DispatchQueue.main.sync {
                step(name, step: actionStep)
            }
        }
    }
    
    /// Step base
    ///
    /// - Parameters
    ///   - name: Step name
    ///   - step: Action
    private func step(_ name: String, step: () -> Void) {
        XCTContext.runActivity(named: name) { _ in
            step()
        }
    }
}

extension XCTest {
    /// Step GIVEN
    ///
    /// - Parameters
    ///   - name: Step name
    ///   - actionStep: Action
    @MainActor
    func GIVEN(_ name: String, asyncStep: @escaping () async -> Void) async {
        return await withCheckedContinuation { con in
            stepAsync("GIVEN \(name)") {
                await asyncStep()
                con.resume()
            }
        }
    }

    /// Step WHEN
    ///
    /// - Parameters
    ///   - name: Step name
    ///   - actionStep: Action
    @MainActor
    func WHEN(_ name: String, asyncStep: @escaping () async -> Void) async {
        return await withCheckedContinuation { con in
            stepAsync("WHEN \(name)") {
                await asyncStep()
                con.resume()
            }
        }
    }

    /// Step AND
    ///
    /// - Parameters
    ///   - name: Step name
    ///   - actionStep: Action
    @MainActor
    func AND(_ name: String, asyncStep: @escaping () async -> Void) async {
        return await withCheckedContinuation { con in
            stepAsync("AND \(name)") {
                await asyncStep()
                con.resume()
            }
        }
    }
    
    /// Step base
    ///
    /// - Parameters
    ///   - name: Step name
    ///   - step: Action
    @MainActor
    private func stepAsync(_ name: String, step: @escaping () async throws -> Void) {
        XCTContext.runActivity(named: name) { _ in
            var thrownError: Error?
            let errorHandler = { thrownError = $0 }
            
            Task {
                do {
                    try await step()
                } catch {
                    errorHandler(error)
                }
            }
            
            if let error = thrownError {
                XCTFail("Async error thrown: \(error)")
            }
        }
    }
}

// XCTestCase helper
extension XCTestCase {
    // Wait for x seconds
    /// Example:
    ///     Wait for 2 seconds
    ///     wait(for: 2)
    /// - parameter second time wait
    func wait(for second: TimeInterval) {
        let delayExpectation = XCTestExpectation()
        delayExpectation.isInverted = true
        wait(for: [delayExpectation], timeout: second)
    }
    
    /// Wait block execute for max x seconds
    /// Example:
    ///     Wait block execute for max 2 seconds
    ///     wait(max: 2) { $0.fulfill() }
    /// - parameter second timeout
    /// - parameter block execute block
    func wait(max second: TimeInterval, block: (XCTestExpectation) -> Void) {
        let expectation = XCTestExpectation(description: "Wait block for max \(second) seconds")
        block(expectation)
        wait(for: [expectation], timeout: second)
    }
}
