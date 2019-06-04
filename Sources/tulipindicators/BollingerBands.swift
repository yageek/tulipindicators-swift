import libindicators

/// The result of a bolling band computations
public struct BBandResult {
    /// The offset relative to the inputs
    /// where the outputs data are valid
    public let beginIdx: Int

    /// The values of the lowest band
    public let lower: [Double]

    /// The values of the middle band
    public let middle: [Double]

    /// The values of the upper band
    public let upper: [Double]
}

/// Compute the values of the three components
/// of the bollinger bands
///
/// - Parameters:
///   - period: The period
///   - stddev: The standard deviation
///   - inputs: The inputs
/// - Returns: The result as `BBBandResult`
public func bollingerBands(period: Int, stddev: Double, inputs: [Double]) -> BBandResult {
    let options: [Double] = [Double(period), Double(stddev)]
    let (beginIdx, outputs) = Bindings.shared.call_indicator(name: "bbands", inputs: inputs, options: options)
    let count = inputs.count - beginIdx
    let splits = stride(from: 0, to: 3*count, by: count).map { Array(outputs[$0..<$0+count])}

    return BBandResult(beginIdx: beginIdx, lower: splits[0], middle: splits[1], upper: splits[2])
}
