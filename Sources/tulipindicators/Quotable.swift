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
 
import Foundation

/// An element representing a Quote
///
/// For the sake of convenience, the protocol provides
/// default implementation for all values that equal zero.
public protocol Quotable {

    /// The high value
    var high: Double { get }

    /// The low value
    var low: Double { get }

    /// The open value
    var open: Double { get }

    /// The close value
    var close: Double { get }

    /// The volume value
    var volume: Int { get }
}

public extension Quotable {
    var high: Double { return 0.0 }
    var low: Double { return 0.0 }
    var open: Double { return 0.0 }
    var close: Double { return 0.0 }
    var volume: Int { return 0 }
}

func HL<T: Quotable>(_ inputs: [T]) -> [Double] {
    var raw_inputs = [Double](repeating: 0.0, count: inputs.count*2)

    for i in 0..<inputs.count {
        raw_inputs[i] = inputs[i].high
        raw_inputs[i+inputs.count] = inputs[i].low
    }
    return raw_inputs
}

func CV<T: Quotable>(_ inputs: [T]) -> [Double] {
    var raw_inputs = [Double](repeating: 0.0, count: inputs.count*2)

    for i in 0..<inputs.count {
        raw_inputs[i] = inputs[i].close
        raw_inputs[i+inputs.count] = Double(inputs[i].volume)
    }
    return raw_inputs
}

func OC<T: Quotable>(_ inputs: [T]) -> [Double] {
    var raw_inputs = [Double](repeating: 0.0, count: inputs.count*2)

    for i in 0..<inputs.count {
        raw_inputs[i] = inputs[i].open
        raw_inputs[i+inputs.count] = inputs[i].close
    }
    return raw_inputs
}

func HLC<T: Quotable>(_ inputs: [T]) -> [Double] {
    var raw_inputs = [Double](repeating: 0.0, count: inputs.count*3)
    for i in 0..<inputs.count {
        raw_inputs[i] = inputs[i].high
        raw_inputs[i+inputs.count] = inputs[i].low
        raw_inputs[i+2*inputs.count] = inputs[i].close
    }
    return raw_inputs
}

func HLV<T: Quotable>(_ inputs: [T]) -> [Double] {
    var raw_inputs = [Double](repeating: 0.0, count: inputs.count*3)
    for i in 0..<inputs.count {
        raw_inputs[i] = inputs[i].high
        raw_inputs[i+inputs.count] = inputs[i].low
        raw_inputs[i+2*inputs.count] = Double(inputs[i].volume)
    }
    return raw_inputs
}

func HLCV<T: Quotable>(_ inputs: [T]) -> [Double] {
    var raw_inputs = [Double](repeating: 0.0, count: inputs.count*4)
    for i in 0..<inputs.count {
        raw_inputs[i] = inputs[i].high
        raw_inputs[i+inputs.count] = inputs[i].low
        raw_inputs[i+2*inputs.count] = inputs[i].close
        raw_inputs[i+3*inputs.count] = Double(inputs[i].volume)
    }
    return raw_inputs
}

func OHLC<T: Quotable>(_ inputs: [T]) -> [Double] {
    var raw_inputs = [Double](repeating: 0.0, count: inputs.count*4)
    for i in 0..<inputs.count {
        raw_inputs[i] = inputs[i].open
        raw_inputs[i+inputs.count] = inputs[i].high
        raw_inputs[i+2*inputs.count] = inputs[i].low
        raw_inputs[i+3*inputs.count] = inputs[i].close
    }
    return raw_inputs
}
