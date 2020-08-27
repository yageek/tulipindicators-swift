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
 
import libindicators

/// Simple moving average
/// - Parameter inputs: The inputs
/// - Parameter n: The period
public func sma(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "sma", inputs: inputs, options: [Double(n)])
}

/// Weighted moving average
/// - Parameter inputs: The inputs
/// - Parameter n: The period
public func wma(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "wma", inputs: inputs, options: [Double(n)])
}

/// Exponential moving average
/// - Parameter inputs: The inputs
/// - Parameter n: The period
public func ema(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "ema", inputs: inputs, options: [Double(n)])
}

/// Double exponential moving average
/// - Parameter inputs: The inputs
/// - Parameter n: The period
public func dema(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "dema", inputs: inputs, options: [Double(n)])
}

/// Triple exponential moving average
/// - Parameter inputs: The inputs
/// - Parameter n: The period
public func tema(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "tema", inputs: inputs, options: [Double(n)])
}

///  Triangular Moving Average
/// - Parameter inputs: The inputs
/// - Parameter n: The period
public func trima(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "trima", inputs: inputs, options: [Double(n)])
}

/// Kaufman Adaptive Moving Average
/// /// - Parameter inputs: The inputs
/// - Parameter n: The period
public func kama(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "kama", inputs: inputs, options: [Double(n)])
}

/// Struct holding the `bbands` result
public struct BBandResult {

    /// The lower values
    public let lower: [Double]
    /// The middle values
    public let middle: [Double]
    /// The upper values
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
    let (beginIdx, outputs) = Tulip.shared.call_indicator(name: "bbands", inputs: inputs, options: options)
    let count = inputs.count - beginIdx
    let splits = stride(from: 0, to: 3*count, by: count).map { Array(outputs[$0..<$0+count])}

    return (beginIdx, BBandResult(lower: splits[0], middle: splits[1], upper: splits[2]))
}

/// Vector Absolute Value
/// - Parameter inputs: The inputs values
public func abs(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "abs", inputs: inputs, options: [])
}

/// - Parameter inputs: The inputs values
public func acos(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "acos", inputs: inputs, options: [])
}

/// Accumulation/Distribution Line
/// - Parameter inputs: An array of `Quotable` elements
public func ad<T: Quotable>(_ inputs: [T]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "ad", inputs: HLCV(inputs), options: [])
}

/// Vector addition
/// - Parameter a: Inputs A
/// - Parameter b: Inputs B
public func add(a: [Double], b: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "add", inputs: a + b, options: [])
}

/// Accumulation/Distribution Oscillator
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter short_period: The short period value
/// - Parameter long_period: The long period value
public func adosc<T: Quotable>(_ inputs: [T], short_period: Double, long_period: Double) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "adosc", inputs: HLCV(inputs), options: [short_period, long_period])
}

/// Average Directional Movement Index
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter period: The period
public func adx<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "adx", inputs: HLC(inputs), options: [Double(n)])
}

/// Average Directional Movement Rating
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter period: The period
public func adxr<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "adx", inputs: HLC(inputs), options: [Double(n)])
}

/// Aweosome Oscillator
/// - Parameter inputs: An arrayof `Quotable` elements.
public func ao<T: Quotable>(_ inputs: [T]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "ao", inputs: HL(inputs), options: [])
}

/// Absolute Price Oscillator
/// - Parameter inputs: The input values
public func apo(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "apo", inputs: inputs, options: [])
}

/// Struct holding `arroon` result
public struct ArroonResult {

    /// The down values
    public let down: [Double]
    /// The up values
    public let up: [Double]
}

/// Aroon
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter n: The period
public func arroon<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, ArroonResult) {

    let (beginIdx, outputs) = Tulip.shared.call_indicator(name: "arroon", inputs: HL(inputs), options: [Double(n)])
    let count = inputs.count - beginIdx
    let splits = stride(from: 0, to: 2*count, by: count).map { Array(outputs[$0..<$0+count])}
    return (beginIdx, ArroonResult(down: splits[0], up: splits[1]))
}

/// Aroon Oscillator
/// - Parameter inputs:  An array of `Quotable` elements
/// - Parameter n: The period
public func aroonosc<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "aroonosc", inputs: HL(inputs), options: [Double(n)])
}

/// Vector Arcsine
/// - Parameter inputs: The inputs values
public func asin(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "asin", inputs: inputs, options: [])
}

/// Vector Arctangent
/// - Parameter inputs: The inputs values
public func atan(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "atan", inputs: inputs, options: [])
}

/// Average True Range
/// - Parameter inputs: The inputs
/// - Parameter n: The period
public func atr<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "atr", inputs: HLC(inputs), options: [Double(n)])
}

/// Average Price
/// - Parameter inputs: An array of `Quotable` elements
public func avgprice<T: Quotable>(_ inputs: [T]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "avgprice", inputs: OHLC(inputs), options: [])
}

/// Balance of Power
/// - Parameter inputs: An array of `Quotable` elements
public func bop<T: Quotable>(_ inputs: [T]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "bop", inputs: OHLC(inputs), options: [])
}

/// Commodity Channel Index
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter n: The period
public func cci<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "cci", inputs: HLC(inputs), options: [Double(n)])
}

/// Vector Ceiling
/// - Parameter inputs: The inputs
public func ceil(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "ceil", inputs: inputs, options: [])
}

/// Chande Momentum Oscillator
/// - Parameter inputs: The inputs
/// - Parameter n: The period
public func cmo(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "cmo", inputs: inputs, options: [Double(n)])
}

/// Vector Cosine
/// - Parameter inputs: The inputs
public func cos(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "cos", inputs: inputs, options: [])
}

/// Vector Hyperbolic Cosine
/// - Parameter inputs: The inputs
public func cosh(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "cosh", inputs: inputs, options: [])
}

/// Crossany
/// - Parameter a: A values
/// - Parameter b: B values
public func crossany(a: [Double], b: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "crossany", inputs: a + b, options: [])
}

/// Crossover
/// - Parameter a: A values
/// - Parameter b: B values
public func crossover(a: [Double], b: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "crossover", inputs: a + b, options: [])
}

/// Chaikins Volatility
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter n: The period
public func cvi<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "cvi", inputs: HL(inputs), options: [])
}

/// Linear Decay
/// - Parameter inputs: The input values
/// - Parameter n: The period
public func decay(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "decay", inputs: inputs, options: [Double(n)])
}

/// Struct holding `di` and `dm` results
public struct Direction {

    /// The plus values
    public let plus: [Double]
    /// The minus values
    public let minus: [Double]
}

/// Directional indicator
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter n: The period n
public func di<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, Direction) {
    let (begin, outputs) = Tulip.shared.call_indicator(name: "di", inputs: HLC(inputs), options: [Double(n)])
    let count = inputs.count - begin
    let splits = stride(from: 0, to: 2*count, by: count).map { Array(outputs[$0..<$0+count])}
    return (begin, Direction(plus: splits[0], minus: splits[1]))
}

/// Vector division
/// - Parameter inputs: The inputs
public func div(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "div", inputs: inputs, options: [])
}

/// Directional Movement
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter n: The period n
public func dm<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, Direction) {
    let (begin, outputs) = Tulip.shared.call_indicator(name: "dm", inputs: HL(inputs), options: [Double(n)])
    let count = inputs.count - begin
    let splits = stride(from: 0, to: 2*count, by: count).map { Array(outputs[$0..<$0+count])}
    return (begin, Direction(plus: splits[0], minus: splits[1]))
}

/// Detrended Price Oscillator
/// - Parameter inputs: The input values
/// - Parameter n: The period
public func dpo(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "dpo", inputs: inputs, options: [Double(n)])
}

/// Directional Movement Index
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter n: The period
public func dx<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "dx", inputs: HLC(inputs), options: [Double(n)])
}

/// Exponential Decay
/// - Parameter inputs: The input values
/// - Parameter n: The period
public func edecay(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "edecay", inputs: inputs, options: [Double(n)])
}

/// Ease of Movement
/// - Parameter inputs: An array of `Quotable` elements
public func emv<T: Quotable>(_ inputs: [T]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "emv", inputs: HLV(inputs), options: [])
}

/// Vector Exponential
/// - Parameter inputs: The inputs
public func exp(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "exp", inputs: inputs, options: [])
}

/// Struct holding `fischer` result
public struct FisherResult {
    /// The fisher values
    public let fisher: [Double]
    /// The signal values
    public let signal: [Double]
}

/// Fisher Transform
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter n: The period
public func fisher<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, FisherResult) {
    let (begin, outputs) = Tulip.shared.call_indicator(name: "fisher", inputs: HL(inputs), options: [Double(n)])
    let count = inputs.count - begin
    let splits = stride(from: 0, to: 2*count, by: count).map { Array(outputs[$0..<$0+count])}
    return (begin, FisherResult(fisher: splits[0], signal: splits[1]))
}

/// Vector Floor
/// - Parameter inputs: The inputs
public func floor(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "floor", inputs: inputs, options: [])
}

/// Forecast Oscillator
/// - Parameter inputs: The input values
/// - Parameter n: The period
public func fosc(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "fosc", inputs: inputs, options: [Double(n)])
}

/// Hull Moving Average
/// - Parameter inputs: The inputs
/// - Parameter n: The period
public func hma(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "hma", inputs: inputs, options: [Double(n)])
}

/// Klinger Volume Oscillator
/// - Parameter inputs: The input values
/// - Parameter short: The short period
/// - Parameter long: The long period
public func kvo<T: Quotable>(_ inputs: [T], short: Int, long: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "kvo", inputs: HLCV(inputs), options: [Double(short), Double(long)])
}

/// Lag
/// - Parameter inputs: The inputs
/// - Parameter inputs: The period
public func lag(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "lag", inputs: inputs, options: [Double(n)])
}

/// Linear Regression
/// - Parameter inputs: The inputs
/// - Parameter inputs: The period
public func linreg(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "linreg", inputs: inputs, options: [Double(n)])
}

/// Linear Regression Intercept
/// - Parameter inputs: The inputs
/// - Parameter inputs: The period
public func linregintercept(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "linregintercept", inputs: inputs, options: [Double(n)])
}

/// Linear Regression Slope
/// - Parameter inputs: The inputs
/// - Parameter inputs: The period
public func linregslope(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "linregslope", inputs: inputs, options: [Double(n)])
}

/// Vector Natural Log
/// - Parameter inputs: The inputs
public func ln(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "ln", inputs: inputs, options: [])
}

/// Vector Base-10 Log
/// - Parameter inputs: The inputs
public func log10(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "log10", inputs: inputs, options: [])
}

/// Struct holding the result of `macd`.
public struct MACDResult {

    /// The macd values
    public let macd: [Double]
    /// The signal values
    public let signal: [Double]
    /// The histogram values
    public let histogram: [Double]
}

/// Moving Average Convergence/Divergence
/// - Parameter inputs: The inputs values
/// - Parameter short: The short period
/// - Parameter long: The long period
/// - Parameter signal: The signal period
public func macd(_ inputs: [Double], short: Int, long: Int, signal: Int) -> (Int, MACDResult) {
    let (beginIdx, outputs) = Tulip.shared.call_indicator(name: "macd", inputs: inputs, options: [Double(short), Double(long), Double(signal)])
    let count = inputs.count - beginIdx

    let splits = stride(from: 0, to: 3*count, by: count).map { Array(outputs[$0..<$0+count])}

    return (beginIdx, MACDResult(macd: splits[0], signal: splits[1], histogram: splits[2]))
}

/// Market Facilitation Index
/// - Parameter inputs: An array of `Quotable` elements.
public func marketfi<T: Quotable>(_ inputs: [T]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "marketfi", inputs: HLV(inputs), options: [])
}

/// Mass Index
/// - Parameter inputs: An array of `Quotable` elements.
public func mass<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "mass", inputs: HL(inputs), options: [Double(n)])
}

/// Maximum In Period
/// - Parameter inputs: An array of `Quotable` elements.
public func max(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "max", inputs: inputs, options: [Double(n)])
}

/// Mean Deviation Over Period
/// - Parameter inputs: An array of `Quotable` elements.
public func md(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "md", inputs: inputs, options: [Double(n)])
}

/// Median Price
/// - Parameter inputs: An array of `Quotable` elements.
public func medprice<T: Quotable>(_ inputs: [T]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "medprice", inputs: HLV(inputs), options: [])
}

/// Money Flow Index
/// - Parameter inputs: An array of `Quotable` elements.
public func mfi<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "mfi", inputs: HLCV(inputs), options: [Double(n)])
}

/// Momentum
/// - Parameter inputs: An array of `Quotable` elements.
public func mom(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "mom", inputs: inputs, options: [Double(n)])
}

/// Struct holding `msw` result
public struct MSWResult {

    /// The sine values
    public let sine: [Double]
    /// The lead values
    public let lead: [Double]
}

/// Mesa Sine Wave
/// - Parameter inputs: The input values
public func msw(_ inputs: [Double], period n: Int) -> (Int, MSWResult) {
    let (beginIdx, outputs) = Tulip.shared.call_indicator(name: "msw", inputs: inputs, options: [Double(n)])
    let count = inputs.count - beginIdx
    let splits = stride(from: 0, to: 2*count, by: count).map { Array(outputs[$0..<$0+count])}
    return (beginIdx, MSWResult(sine: splits[0], lead: splits[1]))
}

/// Vector Multiplication
/// - Parameter inputs: The inputs
public func mul(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "mul", inputs: inputs, options: [])
}

/// Normalized Average True Range
/// - Parameter inputs: An array of `Quotable` elements.
public func natr<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "natr", inputs: HLC(inputs), options: [Double(n)])
}

/// Normalized Average True Range
/// - Parameter inputs: An array of `Quotable` elements.
public func nvi<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "natr", inputs: CV(inputs), options: [Double(n)])
}

/// On Balance Volume
/// - Parameter inputs: An array of `Quotable` elements.
public func obv<T: Quotable>(_ inputs: [T]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "obv", inputs: CV(inputs), options: [])
}

/// Percentage Price Oscillator
/// - Parameter inputs: The inputs
public func ppo(_ inputs: [Double], short: Int, long: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "ppo", inputs: inputs, options: [Double(short), Double(long)])
}

/// Parabolic SAR
/// - Parameter inputs: An array of `Quotable` elements.
/// - Parameter acceleration: The acceleration factor
/// - Parameter accelerationMax: The accelation factor maximum
public func psar<T: Quotable>(_ inputs: [T], acceleration: Double, accelerationMax: Double) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "psar", inputs: HL(inputs), options: [acceleration, accelerationMax])
}

/// Positive Volume Index
/// - Parameter inputs: An array of `Quotable` elements.
public func pvi<T: Quotable>(_ inputs: [T]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "pvi", inputs: CV(inputs), options: [])
}

/// Qstick
/// - Parameter inputs: An array of `Quotable` elements.
/// - Parameter period: The period
public func qstick<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "qstick", inputs: OC(inputs), options: [Double(n)])
}

/// Rate of Change
/// - Parameter inputs: The input values
public func roc(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "roc", inputs: inputs, options: [Double(n)])
}

/// Rate of Change Ratio
/// - Parameter inputs: The input values
public func rocr(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "rocr", inputs: inputs, options: [Double(n)])
}

/// Vector Round
/// - Parameter inputs: The inputs
public func round(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "round", inputs: inputs, options: [])
}

/// Relative Strength Index
/// - Parameter inputs: The input values
public func rsi(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "rsi", inputs: inputs, options: [Double(n)])
}

/// Vector Sine
/// - Parameter inputs: The inputs
public func sin(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "sin", inputs: inputs, options: [])
}

/// Vector Hyperbolic Sine
/// - Parameter inputs: The inputs
public func sinh(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "sinh", inputs: inputs, options: [])
}

/// Vector Sqrt
/// - Parameter inputs: The inputs
public func sqrt(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "sqrt", inputs: inputs, options: [])
}

/// Standard Deviation Over Period
/// - Parameter inputs: The input values
public func stddev(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "stddev", inputs: inputs, options: [Double(n)])
}

/// Standard Error Over Period
/// - Parameter inputs: The input values
public func stderr(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "stderr", inputs: inputs, options: [Double(n)])
}

/// Struct holding `stoch` result
public struct StochResult {

    /// The stoch K values
    public let K: [Double]
    /// The stoch D values
    public let D: [Double]
}

/// Stochastic Oscillator
/// - Parameter inputs: An array of `Quotable` elements.
/// - Parameter period: The period
public func stoch<T: Quotable>(_ inputs: [T], kPeriod: Int, kSlowingPeriod: Int, dPeriod: Int) -> (Int, StochResult) {
    let (beginIdx, outputs) = Tulip.shared.call_indicator(name: "stoch", inputs: HLC(inputs), options: [Double(kPeriod), Double(kSlowingPeriod), Double(dPeriod)])
    let count = inputs.count - beginIdx
    let splits = stride(from: 0, to: 2*count, by: count).map { Array(outputs[$0..<$0+count])}
    return (beginIdx, StochResult(K: splits[0], D: splits[1]))
}

/// Stochastic RSI
/// - Parameter inputs: The input values
public func stochrsi(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "stochrsi", inputs: inputs, options: [Double(n)])
}

/// Vector Substraction
/// - Parameter inputs: The inputs
public func sub(a: [Double], b: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "sub", inputs: a + b, options: [])
}

/// Sum Over Period
/// - Parameter inputs: An array of `Quotable` elements.
public func sum(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "sum", inputs: inputs, options: [Double(n)])
}

/// Vector Tangent
/// - Parameter inputs: The inputs
public func tan(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "tan", inputs: inputs, options: [])
}

/// Vector Hyperbolic Tangent
/// - Parameter inputs: The inputs
public func tanh(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "tanh", inputs: inputs, options: [])
}

/// Vector Degree Conversion
/// - Parameter inputs: The inputs
public func todeg(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "todeg", inputs: inputs, options: [])
}

/// Vector Radian Conversion
/// - Parameter inputs: The inputs
public func torad(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "torad", inputs: inputs, options: [])
}

/// True Range
/// - Parameter inputs: An array of `Quotable` elements
public func tr<T: Quotable>(_ inputs: [T]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "tr", inputs: HLC(inputs), options: [])
}

/// Trix
/// - Parameter inputs: An array of `Quotable` elements.
public func trix(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "trix", inputs: inputs, options: [Double(n)])
}

/// Vector Truncate
/// - Parameter inputs: The inputs
public func trunc(_ inputs: [Double]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "trunc", inputs: inputs, options: [])
}

/// Time Series Forecast
/// - Parameter inputs: An array of `Quotable` elements.
public func tsf(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "tsf", inputs: inputs, options: [Double(n)])
}

/// Typical Price
/// - Parameter inputs: An array of `Quotable` elements
public func typprice<T: Quotable>(_ inputs: [T]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "typprice", inputs: HLC(inputs), options: [])
}

/// Ultimate Oscillator
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter short: The short period
/// - Parameter medium: The medium period
/// - Parameter long: The long period
public func ultosc<T: Quotable>(_ inputs: [T], short: Int, medium: Int, long: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "ultosc", inputs: HLC(inputs), options: [Double(short), Double(medium), Double(long)])
}

/// Variance Over Period
/// - Parameter inputs: The input values
public func variance(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "var", inputs: inputs, options: [Double(n)])
}

/// Vertical Horizontal Filter
/// - Parameter inputs: The input values
public func vhf(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "vhf", inputs: inputs, options: [Double(n)])
}

/// Variable Index Dynamic Average
/// - Parameter inputs: The input values
/// - Parameter short: The short period
/// - Parameter long: The long period
/// - Parameter alpha: The alpha value
public func vidya(_ inputs: [Double], short: Int, long: Int, alpha: Double) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "vidya", inputs: inputs, options: [Double(short), Double(long), alpha])
}

/// Annualized Historical Volatility
/// - Parameter inputs: The input values
public func volatility(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "volatility", inputs: inputs, options: [Double(n)])
}

/// Volume Oscillator
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter short: The short period
/// - Parameter long: The long period
public func vosc<T: Quotable>(_ inputs: [T], short: Int, long: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "vosc", inputs: inputs.map { Double($0.volume) }, options: [Double(short), Double(long)])
}

/// Volume Weighted Moving Average
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter n: The period
public func vwma<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "vwma", inputs: CV(inputs), options: [Double(n)])
}

/// Williams Accumulation/Distribution
/// - Parameter inputs: An array of `Quotable` elements
public func wad<T: Quotable>(_ inputs: [T]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "wad", inputs: HLC(inputs), options: [])
}

/// Weighted Close Price
/// - Parameter inputs: An array of `Quotable` elements
public func wcprice<T: Quotable>(_ inputs: [T]) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "wcprice", inputs: HLC(inputs), options: [])
}

/// Wilders Smoothing
/// - Parameter inputs: The input values
public func wilders(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "wilders", inputs: inputs, options: [Double(n)])
}

/// Weighted Close Price
/// - Parameter inputs: An array of `Quotable` elements
/// - Parameter n: The period
public func willr<T: Quotable>(_ inputs: [T], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "willr", inputs: HLC(inputs), options: [Double(n)])
}

/// Zero-Lag Exponential Moving Average
/// - Parameter inputs: The inputs
/// - Parameter n: The period
public func zlema(_ inputs: [Double], period n: Int) -> (Int, [Double]) {
    return Tulip.shared.call_indicator(name: "zlema", inputs: inputs, options: [Double(n)])
}
