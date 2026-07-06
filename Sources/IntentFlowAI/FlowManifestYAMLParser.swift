import Foundation

public enum FlowManifestParseError: Error, Equatable, CustomStringConvertible, Sendable {
    case missingRequiredField(String)
    case invalidMode(String)

    public var description: String {
        switch self {
        case .missingRequiredField(let field):
            return "Missing required field: \(field)"
        case .invalidMode(let value):
            return "Invalid mode: \(value)"
        }
    }
}

public struct FlowManifestYAMLParser: Sendable {
    public init() {}

    public func parse(_ source: String) throws -> FlowManifest {
        var scalars: [String: String] = [:]
        var arrays: [String: [String]] = [:]
        var currentArrayKey: String?

        for rawLine in source.split(separator: "\n", omittingEmptySubsequences: false) {
            let line = String(rawLine)
            let trimmed = line.trimmingCharacters(in: .whitespaces)

            if trimmed.isEmpty || trimmed.hasPrefix("#") {
                continue
            }

            if trimmed.hasPrefix("- "), let key = currentArrayKey {
                arrays[key, default: []].append(unquote(String(trimmed.dropFirst(2))))
                continue
            }

            guard let separator = trimmed.firstIndex(of: ":") else {
                continue
            }

            let key = String(trimmed[..<separator]).trimmingCharacters(in: .whitespaces)
            let value = String(trimmed[trimmed.index(after: separator)...]).trimmingCharacters(in: .whitespaces)

            if value.isEmpty {
                currentArrayKey = key
                arrays[key, default: []] = arrays[key, default: []]
            } else {
                currentArrayKey = nil
                scalars[key] = unquote(value)
            }
        }

        let feature = try requiredScalar("feature", in: scalars)
        let modeValue = try requiredScalar("mode", in: scalars)
        guard let mode = IntentFlowMode(rawValue: modeValue) else {
            throw FlowManifestParseError.invalidMode(modeValue)
        }

        return FlowManifest(
            schemaVersion: scalars["schemaVersion"] ?? "0.1",
            feature: feature,
            mode: mode,
            summary: scalars["summary"] ?? "",
            states: try requiredArray("states", in: arrays),
            intents: try requiredArray("intents", in: arrays),
            events: arrays["events"] ?? [],
            effects: arrays["effects"] ?? [],
            routes: arrays["routes"] ?? [],
            outputs: arrays["outputs"] ?? [],
            invariants: arrays["invariants"] ?? [],
            acceptanceTraces: arrays["acceptanceTraces"] ?? []
        )
    }

    private func requiredScalar(_ key: String, in scalars: [String: String]) throws -> String {
        guard let value = scalars[key], !value.isEmpty else {
            throw FlowManifestParseError.missingRequiredField(key)
        }
        return value
    }

    private func requiredArray(_ key: String, in arrays: [String: [String]]) throws -> [String] {
        guard let values = arrays[key], !values.isEmpty else {
            throw FlowManifestParseError.missingRequiredField(key)
        }
        return values
    }

    private func unquote(_ value: String) -> String {
        var result = value.trimmingCharacters(in: .whitespaces)
        if result.hasPrefix("\""), result.hasSuffix("\""), result.count >= 2 {
            result.removeFirst()
            result.removeLast()
        }
        return result
    }
}
