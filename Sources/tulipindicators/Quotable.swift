//
//  Quotable.swift
//  
//
//  Created by Yannick Heinrich on 05.06.19.
//

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
