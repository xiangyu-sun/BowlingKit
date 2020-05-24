import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        [
            testCase(BowlingKitTests.allTests),
        ]
    }
#endif
