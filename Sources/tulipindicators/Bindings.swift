import libindicators

// MARK: - Public API
public enum IndicatorKind {
    case overlay
    case math
    case simple
    case comparative
}

// MARK: - Bindings
enum Result: RawRepresentable {
    case Ok
    case InvalidOption

    public var rawValue: Int32 {
        switch self {
        case .Ok: return TI_OKAY
        case .InvalidOption : return TI_INVALID_OPTION
        }
    }

    init?(rawValue: Int32) {
        switch rawValue {
        case TI_OKAY: self = .Ok
        case TI_INVALID_OPTION: self = .InvalidOption
        default:
            return nil
        }
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

struct Bindings {

    static let shared = Bindings()

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

    func call_indicator(name: String, inputs: [Double], options: [Double]) -> (Int, [Double]) {

        let indicator = Bindings.list[name]!
        return call_indicator(indicator, inputs: inputs, options: options)
    }

    private func call_indicator(_ indicator: ti_indicator_info, inputs: [Double], options: [Double]) -> (Int, [Double]) {

        let beginIdx = Int(indicator.start(options))
        let count = inputs.count - beginIdx
        var outputs = [Double](repeating: 0.0, count: Int(indicator.options) * count)

        var result: Int32 = TI_OKAY

        inputs.withUnsafeBufferPointer { (inputs_ptr)  in
            outputs.withUnsafeMutableBufferPointer { (outputs_ptr)  in

                let all_inputs = [inputs_ptr.baseAddress]
                let range = 0..<indicator.outputs
                let all_outputs = range.map { outputs_ptr.baseAddress?.advanced(by: Int($0)*count) }

                result = indicator.indicator(Int32(inputs.count), all_inputs, options, all_outputs)
            }
        }

        assert(result == TI_OKAY)
        return (beginIdx, outputs)
    }
}


