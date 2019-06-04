import XCTest
import tulipindicators

final class BollingerBandsTest: XCTestCase {

    func testBollinger() {
        let inputs: [Double] = [81.59,81.06,82.87,83.00,83.61,83.15,82.84,83.99,84.55,84.36,85.53,86.54,86.89,87.77,87.29]
        let exp_lower: [Double] = [80.530,80.987,82.533,82.472,82.418,82.435,82.511,83.143,83.536,83.870,85.289]
        let exp_middle: [Double] = [82.426,82.738,83.094,83.318,83.628,83.778,84.254,84.994,85.574,86.218,86.804]
        let exp_upper: [Double] = [84.322,84.489,83.655,84.164,84.838,85.121,85.997,86.845,87.612,88.566,88.319]

        let period: Int = 5
        let stddev: Double = 2
        let delta: Double = 1e-3
        let res = bollingerBands(period: period, stddev: stddev, inputs: inputs);
        TIAssert(res.lower, exp_lower, delta);
        TIAssert(res.middle, exp_middle, delta);
        TIAssert(res.upper, exp_upper, delta);
    }
    static var allTests = [("testBollinger", testBollinger)]
}
