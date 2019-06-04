import libindicators

// MARK: - Quote

/// An element representing a quote
///
/// For the sake of convenience, the protocol provides
/// default implementation for all values that equal zero.
public protocol Quote {

    /// The high value
    var high: Double { get }

    /// The low value
    var low: Double { get }

    /// The open value
    var open: Double { get }

    /// The close value
    var close: Double { get }

    /// The volume value
    var volume: Double { get }
}

public extension Quote {
    var high: Double { return 0.0 }
    var low: Double { return 0.0 }
    var open: Double { return 0.0 }
    var close: Double { return 0.0 }
    var volume: Double { return 0.0 }
}

// MARK: - Functions
enum MovingAverage: String {
    /// Simple Moving Average
    case sma
    /// Weighted Moving Average
    case wma
    /// Exponential Moving Average
    case ema
    /// Double Exponential Moving Average
    case dema
    /// Triple Exponential Moving Average
    case tema
    /// Triangular Moving Average
    case trima
    /// Kaufman Adaptive Moving Average
    case kama
}

func movingAverage(_ avg: MovingAverage, period: Int, inputs: [Double]) -> (Int, [Double]) {

    let (beginIdx, outputs) = Bindings.shared.call_indicator(name: avg.rawValue, inputs: inputs, options: [Double(period)])
    return (beginIdx, outputs)
}

public func sma(inputs: [Double], period n: Int) -> (Int, [Double]) {
    return movingAverage(.sma, period: n, inputs: inputs)
}

public func wma(inputs: [Double], period n: Int) -> (Int, [Double]) {
    return movingAverage(.wma, period: n, inputs: inputs)
}

public func ema(inputs: [Double], period n: Int) -> (Int, [Double]) {
    return movingAverage(.ema, period: n, inputs: inputs)
}

public func dema(inputs: [Double], period n: Int) -> (Int, [Double]) {
    return movingAverage(.dema, period: n, inputs: inputs)
}

public func tema(inputs: [Double], period n: Int) -> (Int, [Double]) {
    return movingAverage(.tema, period: n, inputs: inputs)
}

public func trima(inputs: [Double], period n: Int) -> (Int, [Double]) {
    return movingAverage(.trima, period: n, inputs: inputs)
}

public func kama(inputs: [Double], period n: Int) -> (Int, [Double]) {
    return movingAverage(.kama, period: n, inputs: inputs)
}

/// The result of a bolling band computations
public struct BBandResult {
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
/// - Returns: The result as a tuple of (`Int` ,`BBBandResult`)
public func bbands(period: Int, stddev: Double, inputs: [Double]) -> (Int, BBandResult) {
    let options: [Double] = [Double(period), Double(stddev)]
    let (beginIdx, outputs) = Bindings.shared.call_indicator(name: "bbands", inputs: inputs, options: options)
    let count = inputs.count - beginIdx
    let splits = stride(from: 0, to: 3*count, by: count).map { Array(outputs[$0..<$0+count])}

    return (beginIdx, BBandResult(lower: splits[0], middle: splits[1], upper: splits[2]))
}

/// Vector Absolute Value
/// - Parameter inputs: The inputs values
public func abs(inputs: [Double]) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "abs", inputs: inputs, options: [])
}

/// - Parameter inputs: The inputs values
public func acos(inputs: [Double]) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "acos", inputs: inputs, options: [])
}

/// Accumulation/Distribution Line
/// - Parameter inputs: An array of `Quote` elements
public func ad<T: Quote>(inputs: [T]) -> (Int, [Double]) {

    var raw_inputs = [Double](repeating: 0.0, count: inputs.count*4)
    for i in 0..<inputs.count {
        raw_inputs[i] = inputs[i].high
        raw_inputs[i+inputs.count] = inputs[i].low
        raw_inputs[i+2*inputs.count] = inputs[i].close
        raw_inputs[i+3*inputs.count] = inputs[i].volume
    }
    return Bindings.shared.call_indicator(name: "ad", inputs: raw_inputs, options: [])
}

/// Vector addition
/// - Parameter a: Inputs A
/// - Parameter b: Inputs B
public func add(a: [Double], b: [Double]) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "add", inputs: a + b, options: [])
}

/// Accumulation/Distribution Oscillator
/// - Parameter inputs: An array of `Quote` elements
/// - Parameter short_period: The short period value
/// - Parameter long_period: The long period value
public func adosc<T: Quote>(inputs: [T], short_period: Double, long_period: Double) -> (Int, [Double]) {
    var raw_inputs = [Double](repeating: 0.0, count: inputs.count*4)
    for i in 0..<inputs.count {
        raw_inputs[i] = inputs[i].high
        raw_inputs[i+inputs.count] = inputs[i].low
        raw_inputs[i+2*inputs.count] = inputs[i].close
        raw_inputs[i+3*inputs.count] = inputs[i].volume
    }
    return Bindings.shared.call_indicator(name: "adosc", inputs: raw_inputs, options: [short_period, long_period])
}

/// Average Directional Movement Index
/// - Parameter inputs: An array of `Quote` elements
/// - Parameter period: The period
public func adx<T: Quote>(inputs: [T], period n: Int) -> (Int, [Double]) {
    var raw_inputs = [Double](repeating: 0.0, count: inputs.count*3)
    for i in 0..<inputs.count {
        raw_inputs[i] = inputs[i].high
        raw_inputs[i+inputs.count] = inputs[i].low
        raw_inputs[i+2*inputs.count] = inputs[i].close
    }
    return Bindings.shared.call_indicator(name: "adx", inputs: raw_inputs, options: [Double(n)])
}

/// Average Directional Movement Rating
/// - Parameter inputs: An array of `Quote` elements
/// - Parameter period: The period
public func adxr<T: Quote>(inputs: [T], period n: Int) -> (Int, [Double]) {
    var raw_inputs = [Double](repeating: 0.0, count: inputs.count*3)
    for i in 0..<inputs.count {
        raw_inputs[i] = inputs[i].high
        raw_inputs[i+inputs.count] = inputs[i].low
        raw_inputs[i+2*inputs.count] = inputs[i].close
    }
    return Bindings.shared.call_indicator(name: "adx", inputs: raw_inputs, options: [Double(n)])
}

/// Aweosome Oscillator
/// - Parameter inputs: An arrayof `Quote` elements.
public func ao<T: Quote>(inputs: [T]) -> (Int, [Double]) {
    var raw_inputs = [Double](repeating: 0.0, count: inputs.count*2)
    for i in 0..<inputs.count {
        raw_inputs[i] = inputs[i].high
        raw_inputs[i+inputs.count] = inputs[i].low
    }
    return Bindings.shared.call_indicator(name: "ao", inputs: raw_inputs, options: [])
}

/// Absolute Price Oscillator
/// - Parameter inputs: The input values
public func apo(inputs: [Double]) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "apo", inputs: inputs, options: [])
}

public struct ArroonResult {
    let down: [Double]
    let up: [Double]
}

public func arroon<T: Quote>(inputs: [T], period n: Int) -> (Int, ArroonResult) {
    var raw_inputs = [Double](repeating: 0.0, count: inputs.count*2)

    for i in 0..<inputs.count {
        raw_inputs[i] = inputs[i].high
        raw_inputs[i+inputs.count] = inputs[i].low
    }
    let (beginIdx, outputs) = Bindings.shared.call_indicator(name: "ao", inputs: raw_inputs, options: [Double(n)])
    let count = inputs.count - beginIdx
    let splits = stride(from: 0, to: 2*count, by: count).map { Array(outputs[$0..<$0+count])}
    return (beginIdx, ArroonResult(down: splits[0], up: splits[1]))
}
