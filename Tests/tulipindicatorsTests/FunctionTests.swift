import XCTest
import tulipindicators

final class BollingerBandsTest: XCTestCase {

    // MARK: - Moving Average
    private let inputs: [Double] = [81.59,81.06,82.87,83.00,83.61,83.15,82.84,83.99,84.55,84.36,85.53,86.54,86.89,87.77,87.29]
    private let period = 5
    private let delta: Double = 1e-3

    func runAVGTest(_ type: MovingAverage, _ expected: [Double], file: StaticString = #file, line: UInt = #line) {
        let (_, res) = movingAverage(type, period: period, inputs: inputs)
        TIAssert(expected, res, delta, file: file, line: line)
    }

    func testSMA() {
        let expected: [Double] = [82.426,82.738,83.094,83.318,83.628,83.778,84.254,84.994,85.574,86.218,86.804]
        runAVGTest(.sma, expected)
    }

    func testWMA() {
        let expected: [Double] = [82.825,83.066,83.100,83.399,83.809,84.053,84.637,85.399,86.031,86.763,87.121]
        runAVGTest(.wma, expected)
    }

    func testEMA() {
        let expected: [Double] = [81.590,81.413,81.899,82.266,82.714,82.859,82.853,83.232,83.671,83.901,84.444,85.143,85.725,86.407,86.701]
        runAVGTest(.ema, expected)
    }

    func testDEMA() {
        let expected: [Double] = [84.159,84.379,85.125,86.062,86.727,87.529,87.646]
        runAVGTest(.dema, expected)
    }

    func testTEMA() {
        let expected: [Double] = [87.042,87.819,87.721]
        runAVGTest(.tema, expected)
    }

    func testTRIMA() {
        let expected: [Double] = [82.437,82.908,83.204,83.260,83.440,83.807,84.302,84.863,85.537,86.288,86.901]
        runAVGTest(.trima, expected)
    }

    func testKAMA() {
        let expected: [Double] = [83.610,83.560,83.452,83.506,83.647,83.686,84.126,85.026,85.690,86.447,86.673]
        runAVGTest(.kama, expected)
    }

    // MARK: - Bollinger Band
    func testBollinger() {
        let inputs: [Double] = [81.59,81.06,82.87,83.00,83.61,83.15,82.84,83.99,84.55,84.36,85.53,86.54,86.89,87.77,87.29]
        let exp_lower: [Double] = [80.530,80.987,82.533,82.472,82.418,82.435,82.511,83.143,83.536,83.870,85.289]
        let exp_middle: [Double] = [82.426,82.738,83.094,83.318,83.628,83.778,84.254,84.994,85.574,86.218,86.804]
        let exp_upper: [Double] = [84.322,84.489,83.655,84.164,84.838,85.121,85.997,86.845,87.612,88.566,88.319]

        let period: Int = 5
        let stddev: Double = 2
        let delta: Double = 1e-3
        let (_,res) = bbands(period: period, stddev: stddev, inputs: inputs);
        TIAssert(res.lower, exp_lower, delta);
        TIAssert(res.middle, exp_middle, delta);
        TIAssert(res.upper, exp_upper, delta);
    }

    // MARK: - All tests
    static var allTests = [
        ("testSMA", testSMA),
        ("testWMA", testWMA),
        ("testEMA", testEMA),
        ("testDEMA", testDEMA),
        ("testTEMA", testTEMA),
        ("testTRIMA", testTRIMA),
        ("testTRIMA", testKAMA),
        ("testBollinger", testBollinger)
    ]
}
