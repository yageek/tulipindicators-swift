import XCTest
import tulipindicators

final class MovingAverages: XCTestCase {

    private let inputs: [Double] = [81.59,81.06,82.87,83.00,83.61,83.15,82.84,83.99,84.55,84.36,85.53,86.54,86.89,87.77,87.29]
    private let period = 5
    private let delta: Double = 1e-3

    func runTest(_ type: MovingAverage, _ expected: [Double], file: StaticString = #file, line: UInt = #line) {
        let res = movingAverage(type, period: period, inputs: inputs)
        TIAssert(expected, res.outputs, delta, file: file, line: line)
    }

    func testSMA() {
        let expected: [Double] = [82.426,82.738,83.094,83.318,83.628,83.778,84.254,84.994,85.574,86.218,86.804]
        runTest(.Simple, expected)
    }

    func testWMA() {
        let expected: [Double] = [82.825,83.066,83.100,83.399,83.809,84.053,84.637,85.399,86.031,86.763,87.121]
         runTest(.Weighted, expected)
    }

    func testEMA() {
        let expected: [Double] = [81.590,81.413,81.899,82.266,82.714,82.859,82.853,83.232,83.671,83.901,84.444,85.143,85.725,86.407,86.701]
       runTest(.Exp, expected)
    }

    func testDEMA() {
        let expected: [Double] = [84.159,84.379,85.125,86.062,86.727,87.529,87.646]
        runTest(.DoubleExp, expected)
    }

    func testTEMA() {
        let expected: [Double] = [87.042,87.819,87.721]
        runTest(.TripleExp, expected)
    }

    func testTRIMA() {
        let expected: [Double] = [82.437,82.908,83.204,83.260,83.440,83.807,84.302,84.863,85.537,86.288,86.901]
        runTest(.Triangle, expected)
    }

    func testKAMA() {
        let expected: [Double] = [83.610,83.560,83.452,83.506,83.647,83.686,84.126,85.026,85.690,86.447,86.673]
        runTest(.Kaufman, expected)
    }
    static var allTests = [
        ("testSMA", testSMA),
        ("testWMA", testWMA),
        ("testEMA", testEMA),
        ("testDEMA", testDEMA),
        ("testTEMA", testTEMA),
        ("testTRIMA", testTRIMA),
        ("testTRIMA", testKAMA),
    ]
}
