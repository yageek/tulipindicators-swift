import XCTest

#if !os(macOS) && !os(iOS) && !os(tvOS) && !os(watchOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(MovingAveragesTests.allTests),
        testCase(BollingerBandsTest.allTests)   
    ]
}
#endif
