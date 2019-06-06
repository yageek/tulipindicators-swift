/*
 * tulipindicators-swfit
 * https://tulipindicators.org/
 * Copyright (c) 2019 Yannick Heinrich
 * Yannick Heinrich (me@yageek.net)
 *
 * This file is part of tulipindicators-swfit.
 *
 * Tulip Indicators is free software: you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or (at your
 * option) any later version.
 *
 * Tulip Indicators is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License
 * for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Tulip Indicators.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

import XCTest
@testable import tulipindicators

final class FunctionTests: XCTestCase {

    private struct Quote: Quotable {
        let high: Double
        let low: Double
        let open: Double
        let close: Double
        let volume: Int

        init(high: Double = 0.0, low: Double = 0.0, open: Double = 0.0, close: Double = 0.0, volume: Int = 0) {
            self.high = high
            self.low = low
            self.open = open
            self.close = close
            self.volume = volume
        }
    }


    // MARK: - Moving Average
    private let inputs: [Double] = [81.59,81.06,82.87,83.00,83.61,83.15,82.84,83.99,84.55,84.36,85.53,86.54,86.89,87.77,87.29]
    private let period = 5
    private let delta: Double = 1e-3

    func runAVGTest(_ fn: (_ inputs: [Double], _ period: Int) -> (Int, [Double]), _ expected: [Double], file: StaticString = #file, line: UInt = #line) {
        let (_, res) = fn(inputs, period)
        TIAssert(expected, res, delta, file: file, line: line)
    }

    func testSMA() {
        let expected: [Double] = [82.426,82.738,83.094,83.318,83.628,83.778,84.254,84.994,85.574,86.218,86.804]
        runAVGTest(sma, expected)
    }

    func testWMA() {
        let expected: [Double] = [82.825,83.066,83.100,83.399,83.809,84.053,84.637,85.399,86.031,86.763,87.121]
        runAVGTest(wma, expected)
    }

    func testEMA() {
        let expected: [Double] = [81.590,81.413,81.899,82.266,82.714,82.859,82.853,83.232,83.671,83.901,84.444,85.143,85.725,86.407,86.701]
        runAVGTest(ema, expected)
    }

    func testDEMA() {
        let expected: [Double] = [84.159,84.379,85.125,86.062,86.727,87.529,87.646]
        runAVGTest(dema, expected)
    }

    func testTEMA() {
        let expected: [Double] = [87.042,87.819,87.721]
        runAVGTest(tema, expected)
    }

    func testTRIMA() {
        let expected: [Double] = [82.437,82.908,83.204,83.260,83.440,83.807,84.302,84.863,85.537,86.288,86.901]
        runAVGTest(trima, expected)
    }

    func testKAMA() {
        let expected: [Double] = [83.610,83.560,83.452,83.506,83.647,83.686,84.126,85.026,85.690,86.447,86.673]
        runAVGTest(kama, expected)
    }

    func testBBANDS() {
        let inputs: [Double] = [81.59,81.06,82.87,83.00,83.61,83.15,82.84,83.99,84.55,84.36,85.53,86.54,86.89,87.77,87.29]
        let exp_lower: [Double] = [80.530,80.987,82.533,82.472,82.418,82.435,82.511,83.143,83.536,83.870,85.289]
        let exp_middle: [Double] = [82.426,82.738,83.094,83.318,83.628,83.778,84.254,84.994,85.574,86.218,86.804]
        let exp_upper: [Double] = [84.322,84.489,83.655,84.164,84.838,85.121,85.997,86.845,87.612,88.566,88.319]


        let stddev: Double = 2
        let delta: Double = 1e-3
        let (_,res) = bbands(inputs, period: period, stddev: stddev);
        TIAssert(res.lower, exp_lower, delta);
        TIAssert(res.middle, exp_middle, delta);
        TIAssert(res.upper, exp_upper, delta);
    }

    func testFisher() {
        let high: [Double] = [82.15, 81.89, 83.03, 83.30, 83.85, 83.90, 83.33, 84.30, 84.84, 85.00, 85.90, 86.58, 86.98, 88.00, 87.87]
        let low: [Double] = [81.29, 80.64, 81.31, 82.65, 83.07, 83.11, 82.49, 82.30, 84.15, 84.11, 84.03, 85.39, 85.76, 87.17, 87.01]
        let exp_fisher = [0.34, 0.79, 0.83, 0.81, 1.07, 1.44, 1.85, 2.28, 2.70, 3.12, 3.19]
        let exp_signal = [0.00, 0.34, 0.79, 0.83, 0.81, 1.07, 1.44, 1.85, 2.28, 2.70, 3.12]

        let delta: Double = 1e-2
        let period: Int = 5
        let quotes = zip(high, low).map { Quote(high: $0.0, low: $0.1) }

        let (_, res) = fisher(quotes, period: period)
        TIAssert(res.fisher, exp_fisher, delta)
        TIAssert(res.signal, exp_signal, delta)
    }

    func testMSW() {
        let inputs: [Double] = [81.59, 81.06, 82.87, 83.00, 83.61, 83.15, 82.84, 83.99, 84.55, 84.36, 85.53, 86.54, 86.89, 87.77, 87.29]
        let exp_sine: [Double] = [-0.06, -0.72, 0.61, 1.00, 0.52, 0.43, 0.86, 0.67, 0.44, 0.22]
        let exp_lead: [Double] = [-0.75, -1.00, 0.99, 0.64, -0.24, -0.33, 0.25, -0.05, -0.32, -0.53]

        let delta: Double = 1e-2
        let period: Int = 5
        let (_, res) = msw(inputs, period: period)
        TIAssert(res.sine, exp_sine, delta)
        TIAssert(res.lead, exp_lead, delta)
    }
    
    // MARK: - Info
    func testInfo() {
        let info = Tulip.indicator_info(name: "sma")
        XCTAssertEqual("sma", info.name)
        XCTAssertEqual("Simple Moving Average", info.fullName)
        XCTAssertEqual(.overlay, info.kind)
        XCTAssertEqual(["period"], info.options)
        XCTAssertEqual(["sma"], info.outputs)
        XCTAssertEqual(["real"], info.inputs)
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
        ("testBollinger", testBBANDS),
        ("testInfo", testInfo)
    ]
}
