import libindicators

/// The kind of the indicator
public enum IndicatorKind {
    /// The indicator is an overlay
    case overlay
    /// The indicator is simple math
    case math
    /// The indicator is a simple indicator
    case simple
    /// The indicator is a comparative indicator
    case comparative
}

private func arguments(array: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>?, count: Int32) -> [String] {

    var args: [String] = [String](repeating: "", count: Int(count))
    for i in 0..<Int(count) {
        args[i] = String(cString: array![i]!, encoding: .ascii) ?? "??"
    }
    return args
}

/// A struct holding the information about an indicator
public struct IndicatorInfo {

    /// The name of the indicator
    public let name: String

    /// A desriptive name of the indicator
    public let fullName: String

    /// The names of the required inputs
    public let inputs: [String]

    /// The names of the required options
    public let options: [String]

    /// The names of the geneated outputs
    public let outputs: [String]

    /// The kind of the indicator
    public let kind: IndicatorKind

    init(tulip_info: ti_indicator_info) {
        var tulip_info = tulip_info
        self.name = String(cString: tulip_info.name, encoding: .ascii) ?? "??"
        self.fullName = String(cString: tulip_info.full_name, encoding: .ascii) ?? "??"
        self.kind = IndicatorKind(rawValue: tulip_info.type)!
        self.inputs = arguments(array: ti_indicator_info_get_input_names(&tulip_info), count: tulip_info.options)
        self.options = arguments(array: ti_indicator_info_get_option_names(&tulip_info), count: tulip_info.options)
        self.outputs = arguments(array: ti_indicator_info_get_output_names(&tulip_info), count: tulip_info.options)
    }
}

extension IndicatorKind: RawRepresentable {
    public var rawValue: Int32 {
        switch self {

        case .overlay:
            return TI_TYPE_OVERLAY
        case .math:
            return TI_TYPE_MATH
        case .simple:
            return TI_TYPE_SIMPLE
        case .comparative:
            return TI_TYPE_COMPARATIVE
        }
    }

    public init?(rawValue: Int32) {
        switch rawValue {
        case TI_TYPE_OVERLAY:
            self = .overlay
        case TI_TYPE_INDICATOR:
            self = .math
        case TI_TYPE_SIMPLE:
            self = .simple
        case TI_TYPE_COMPARATIVE:
            self = .comparative
        default:
            return nil
        }
    }
}


/// Low level struct to be able to call `tulip` library directly
public struct Tulip {
    /// Call the `tulip` library directly. See the [tulip indicator list](https://tulipindicators.org/list)
    /// for more information
    /// - Parameter name: The name of the indicator
    /// - Parameter inputs: The array of inputs value
    /// - Parameter options: The array of options value
    public static func call_indicator(name: String, inputs: [Double], options: [Double]) -> (Int, [Double]) {
        return Tulip.shared.call_indicator(name: name, inputs: inputs, options: options)
    }

    /// Get the information about one indicator
    /// - Parameter name: The name of the indicator
    public static func indicator_info(name: String) -> IndicatorInfo {
        let indicator = Tulip.shared.indicator_info(by: name)
        return IndicatorInfo(tulip_info: indicator)
    }

    static let shared = Tulip()

    private init() { }

    private static var list: [String: ti_indicator_info] = {
        var entry_ptr = ti_indicators_ptr
        var indicators = [String: ti_indicator_info]()
        while let info = entry_ptr?.pointee, info.name != nil {
            indicators[String(cString: info.name)] = info
            entry_ptr = entry_ptr?.advanced(by: 1)
        }
        return indicators
    }()

    func indicator_info(by name: String) -> ti_indicator_info {
        return Tulip.list[name]!
    }

    func call_indicator(name: String, inputs: [Double], options: [Double]) -> (Int, [Double]) {
        return call_indicator(indicator_info(by: name), inputs: inputs, options: options)
    }

    private func call_indicator(_ indicator: ti_indicator_info, inputs: [Double], options: [Double]) -> (Int, [Double]) {

        let in_size = inputs.count/Int(indicator.inputs)
        let beginIdx = Int(indicator.start(options))
        let count = in_size - beginIdx
        var outputs = [Double](repeating: 0.0, count: Int(indicator.outputs) * count)

        var result: Int32 = TI_OKAY

        inputs.withUnsafeBufferPointer { (inputs_ptr)  in
            outputs.withUnsafeMutableBufferPointer { (outputs_ptr)  in

                let in_range = 0..<indicator.inputs
                let all_inputs = in_range.map { inputs_ptr.baseAddress?.advanced(by: Int($0)*in_size) }

                let out_range = 0..<indicator.outputs
                let all_outputs = out_range.map { outputs_ptr.baseAddress?.advanced(by: Int($0)*count) }

                result = indicator.indicator(Int32(in_size), all_inputs, options, all_outputs)
            }
        }

        assert(result == TI_OKAY)
        return (beginIdx, outputs)
    }
}
