import XCTest

func TIAssert(_ left: @autoclosure () -> [Double], _ right: @autoclosure () -> [Double], _ delta: Double, file: StaticString = #file, line: UInt = #line) {

    let lhs = left()
    let rhs = right()

    XCTAssertEqual(lhs.count, rhs.count, "Both elements should have the same length", file: file, line: line)

    for i in 0..<lhs.count {
        XCTAssert( abs(lhs[i] - rhs[i]) <= delta , "abs(lhs[\(i)]-rhs[\(i)]) > delta => abs(\(lhs[i]) - \(rhs[i])) > \(delta)", file: file, line: line)
    }
}
