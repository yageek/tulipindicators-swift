import libindicators

/// Simple moving average
/// - Parameter inputs: The inputs
/// - Parameter n: The period
public func sma(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "sma", inputs: inputs, options: [Double(n)])
}

/// Weighted moving average
/// - Parameter inputs: The inputs
/// - Parameter n: The period
public func wma(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "wma", inputs: inputs, options: [Double(n)])
}

/// Exponential moving average
/// - Parameter inputs: The inputs
/// - Parameter n: The period
public func ema(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "ema", inputs: inputs, options: [Double(n)])
}

/// Double exponential moving average
/// - Parameter inputs: The inputs
/// - Parameter n: The period
public func dema(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "dema", inputs: inputs, options: [Double(n)])
}

/// Triple exponential moving average
/// - Parameter inputs: The inputs
/// - Parameter n: The period
public func tema(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "tema", inputs: inputs, options: [Double(n)])
}

///  Triangular Moving Average
/// - Parameter inputs: The inputs
/// - Parameter n: The period
public func trima(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "trima", inputs: inputs, options: [Double(n)])
}

/// Kaufman Adaptive Moving Average
/// /// - Parameter inputs: The inputs
/// - Parameter n: The period
public func kama(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "kama", inputs: inputs, options: [Double(n)])
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
public func bbands(_ inputs: [Double], period: Int, stddev: Double) -> (Int, BBandResult) {
    let options: [Double] = [Double(period), Double(stddev)]
    let (beginIdx, outputs) = Bindings.shared.call_indicator(name: "bbands", inputs: inputs, options: options)
    let count = inputs.count - beginIdx
    let splits = stride(from: 0, to: 3*count, by: count).map { Array(outputs[$0..<$0+count])}

    return (beginIdx, BBandResult(lower: splits[0], middle: splits[1], upper: splits[2]))
}

/// Vector Absolute Value
/// - Parameter inputs: The inputs values
public func abs(_ inputs: [Double]) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "abs", inputs: inputs, options: [])
}

/// - Parameter inputs: The inputs values
public func acos(_ inputs: [Double]) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "acos", inputs: inputs, options: [])
}

/// Accumulation/Distribution Line
/// - Parameter inputs: An array of `Quotable` elements
public func ad<T: Quotable>(_ inputs: [T]) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "ad", inputs: HLCV(inputs), options: [])
}

/// Vector addition
/// - Parameter a: Inputs A
/// - Parameter b: Inputs B
public func add(a: [Double], b: [Double]) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "add", inputs: a + b, options: [])
}

/// Accumulation/Distribution Oscillator
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter short_period: The short period value
/// - Parameter long_period: The long period value
public func adosc<T: Quotable>(_ inputs: [T], short_period: Double, long_period: Double) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "adosc", inputs: HLCV(inputs), options: [short_period, long_period])
}

/// Average Directional Movement Index
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter period: The period
public func adx<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "adx", inputs: HLC(inputs), options: [Double(n)])
}

/// Average Directional Movement Rating
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter period: The period
public func adxr<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "adx", inputs: HLC(inputs), options: [Double(n)])
}

/// Aweosome Oscillator
/// - Parameter inputs: An arrayof `Quotable` elements.
public func ao<T: Quotable>(_ inputs: [T]) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "ao", inputs: HL(inputs), options: [])
}

/// Absolute Price Oscillator
/// - Parameter inputs: The input values
public func apo(_ inputs: [Double]) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "apo", inputs: inputs, options: [])
}

public struct ArroonResult {
    let down: [Double]
    let up: [Double]
}

/// Aroon
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter n: The period
public func arroon<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, ArroonResult) {

    let (beginIdx, outputs) = Bindings.shared.call_indicator(name: "arroon", inputs: HL(inputs), options: [Double(n)])
    let count = inputs.count - beginIdx
    let splits = stride(from: 0, to: 2*count, by: count).map { Array(outputs[$0..<$0+count])}
    return (beginIdx, ArroonResult(down: splits[0], up: splits[1]))
}

/// Aroon Oscillator
/// - Parameter inputs:  An array of `Quotable` elements
/// - Parameter n: The period
public func aroonosc<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "aroonosc", inputs: HL(inputs), options: [Double(n)])
}

/// Vector Arcsine
/// - Parameter inputs: The inputs values
public func asin(_ inputs: [Double]) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "asin", inputs: inputs, options: [])
}

/// Vector Arctangent
/// - Parameter inputs: The inputs values
public func atan(_ inputs: [Double]) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "atan", inputs: inputs, options: [])
}

/// Average True Range
/// - Parameter inputs: The inputs
/// - Parameter n: The period
public func atr<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "atr", inputs: HLC(inputs), options: [Double(n)])
}

/// Average Price
/// - Parameter inputs: An array of `Quotable` elements
public func avgprice<T: Quotable>(_ inputs: [T]) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "avgprice", inputs: OHLC(inputs), options: [])
}

/// Balance of Power
/// - Parameter inputs: An array of `Quotable` elements
public func bop<T: Quotable>(_ inputs: [T]) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "bop", inputs: OHLC(inputs), options: [])
}

/// Commodity Channel Index
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter n: The period
public func cci<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "cci", inputs: HLC(inputs), options: [Double(n)])
}

/// Vector Ceiling
/// - Parameter inputs: The inputs
public func ceil(_ inputs: [Double]) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "ceil", inputs: inputs, options: [])
}

/// Chande Momentum Oscillator
/// - Parameter inputs: The inputs
/// - Parameter n: The period
public func cmo(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "cmo", inputs: inputs, options: [Double(n)])
}

/// Vector Cosine
/// - Parameter inputs: The inputs
public func cos(_ inputs: [Double]) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "cos", inputs: inputs, options: [])
}

/// Vector Hyperbolic Cosine
/// - Parameter inputs: The inputs
public func cosh(_ inputs: [Double]) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "cosh", inputs: inputs, options: [])
}

/// Crossany
/// - Parameter a: A values
/// - Parameter b: B values
public func crossany(a: [Double], b: [Double]) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "crossany", inputs: a + b, options: [])
}

/// Crossover
/// - Parameter a: A values
/// - Parameter b: B values
public func crossover(a: [Double], b: [Double]) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "crossover", inputs: a + b, options: [])
}

/// Chaikins Volatility
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter n: The period
public func cvi<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "cvi", inputs: HL(inputs), options: [])
}

/// Linear Decay
/// - Parameter inputs: The input values
/// - Parameter n: The period
public func decay(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "decay", inputs: inputs, options: [Double(n)])
}

/// A struc representing the result of directio function
public struct Direction {

    /// The plus values
    let plus: [Double]

    /// The minus values
    let minus: [Double]
}

/// Directional indicator
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter n: The period n
public func di<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, Direction) {
    let (begin, outputs) = Bindings.shared.call_indicator(name: "di", inputs: HLC(inputs), options: [Double(n)])
    let count = inputs.count - begin
    let splits = stride(from: 0, to: 2*count, by: count).map { Array(outputs[$0..<$0+count])}
    return (begin, Direction(plus: splits[0], minus: splits[1]))
}

/// Vector division
/// - Parameter inputs: The inputs
public func div(_ inputs: [Double]) -> (Int, [Double]) {
    return Bindings.shared.call_indicator(name: "div", inputs: inputs, options: [])
}

/// Directional Movement
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter n: The period n
public func dm<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, Direction) {
    let (begin, outputs) = Bindings.shared.call_indicator(name: "dm", inputs: HL(inputs), options: [Double(n)])
    let count = inputs.count - begin
    let splits = stride(from: 0, to: 2*count, by: count).map { Array(outputs[$0..<$0+count])}
    return (begin, Direction(plus: splits[0], minus: splits[1]))
}

