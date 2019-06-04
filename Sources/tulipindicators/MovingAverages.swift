import Foundation
import libindicators

/// MovingAverage represents the different kind
/// of mocing averages.
public enum MovingAverage {
    
    /// The result of a moving average processing
    public struct Result {

        /// The offset relative to the inputs
        /// where the outputs data are valid
        public let inputIndexOffset: Int

        /// The outputs of the moving average
        public let outputs: [Double]
    }

    case Simple, Weighted, Exp, DoubleExp, TripleExp, Triangle, Kaufman

    fileprivate var shortName: String {
        switch self {
        case .Simple:
            return "sma"
        case .Weighted:
            return "wma"
        case .Exp:
            return "ema"
        case .DoubleExp:
            return "dema"
        case .TripleExp:
            return "tema"
        case .Triangle:
            return "trima"
        case .Kaufman:
            return "kama"
        }
    }
}

/// Computes the moving average of on the period for the provided inputs
///
/// - Parameters:
///   - avg: The `MovingAverage` kind
///   - period: The period of the moving average
///   - inputs: The inputs data
/// - Returns: The result as `MovingAverage.Result`
public func movingAverage(_ avg: MovingAverage, period: Int, inputs: [Double]) -> MovingAverage.Result {

    let (beginIdx, outputs) = Bindings.shared.call_indicator(name: avg.shortName, inputs: inputs, options: [Double(period)])
    return MovingAverage.Result(inputIndexOffset: beginIdx, outputs: outputs)
}
