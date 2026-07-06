import Foundation
import IntentFlowAI

enum UIKind: String {
    case swiftui
    case uikit
    case none
}

enum GeneratorError: Error, CustomStringConvertible {
    case missingFeatureName
    case invalidMode(String)
    case invalidUI(String)
    case missingManifestPath

    var description: String {
        switch self {
        case .missingFeatureName:
            return Self.usage
        case .invalidMode(let value):
            return "Invalid mode '\(value)'. Expected core or ai."
        case .invalidUI(let value):
            return "Invalid ui '\(value)'. Expected swiftui, uikit, or none."
        case .missingManifestPath:
            return "Usage: intentflow validate <path-to-manifest.intentflow.yaml>"
        }
    }

    static var usage: String {
        """
        Usage:
          intentflow feature <Name> [--mode core|ai] [--ui swiftui|uikit|none] [--output path]
          intentflow generate feature <Name> [--mode core|ai] [--ui swiftui|uikit|none] [--output path]
          intentflow validate <path-to-manifest.intentflow.yaml>
        """
    }
}

@main
struct IntentFlowGenerate {
    static func main() throws {
        do {
            try run(arguments: Array(CommandLine.arguments.dropFirst()))
        } catch let error as GeneratorError {
            FileHandle.standardError.write(Data(error.description.utf8))
            FileHandle.standardError.write(Data("\n".utf8))
            Foundation.exit(2)
        }
    }

    static func run(arguments: [String]) throws {
        guard let command = arguments.first else {
            throw GeneratorError.missingFeatureName
        }

        switch command {
        case "feature":
            try runFeature(arguments: arguments)
        case "generate":
            try runGenerate(arguments: Array(arguments.dropFirst()))
        case "validate":
            try runValidate(arguments: Array(arguments.dropFirst()))
        case "--help", "-h", "help":
            print(GeneratorError.usage)
        default:
            throw GeneratorError.missingFeatureName
        }
    }

    static func runGenerate(arguments: [String]) throws {
        guard arguments.first == "feature" else {
            throw GeneratorError.missingFeatureName
        }
        try runFeature(arguments: arguments)
    }

    static func runFeature(arguments: [String]) throws {
        guard arguments.first == "feature", arguments.count >= 2 else {
            throw GeneratorError.missingFeatureName
        }

        let name = arguments[1]
        var mode: IntentFlowMode = .core
        var ui: UIKind = .none
        var output = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)

        var index = 2
        while index < arguments.count {
            let argument = arguments[index]
            let value = index + 1 < arguments.count ? arguments[index + 1] : nil

            switch argument {
            case "--mode":
                guard let value, let parsed = IntentFlowMode(rawValue: value) else {
                    throw GeneratorError.invalidMode(value ?? "")
                }
                mode = parsed
                index += 2

            case "--ui":
                guard let value, let parsed = UIKind(rawValue: value) else {
                    throw GeneratorError.invalidUI(value ?? "")
                }
                ui = parsed
                index += 2

            case "--output":
                guard let value else {
                    throw GeneratorError.missingFeatureName
                }
                output = URL(fileURLWithPath: value)
                index += 2

            default:
                index += 1
            }
        }

        try generate(name: name, mode: mode, ui: ui, output: output)
    }

    static func runValidate(arguments: [String]) throws {
        guard let path = arguments.first else {
            throw GeneratorError.missingManifestPath
        }

        let manifest = try loadManifest(at: URL(fileURLWithPath: path))
        let issues = FlowManifestValidator().validate(manifest)
        let errors = issues.filter { $0.severity == .error }

        if issues.isEmpty {
            print("IntentFlow manifest is valid: \(manifest.feature)")
            return
        }

        for issue in issues {
            print("[\(issue.severity.rawValue)] \(issue.message)")
        }

        if !errors.isEmpty {
            Foundation.exit(1)
        }
    }

    static func loadManifest(at url: URL) throws -> FlowManifest {
        let source = try String(contentsOf: url, encoding: .utf8)
        return try FlowManifestYAMLParser().parse(source)
    }

    static func generate(
        name: String,
        mode: IntentFlowMode,
        ui: UIKind,
        output: URL
    ) throws {
        let template = FeatureTemplate(name: name, mode: mode, ui: ui)
        let featureURL = output.appendingPathComponent(name, isDirectory: true)
        try FileManager.default.createDirectory(at: featureURL, withIntermediateDirectories: true)

        try write(template.contract, to: featureURL.appendingPathComponent("\(name)Contract.swift"))
        try write(template.flow, to: featureURL.appendingPathComponent("\(name)Flow.swift"))
        try write(template.effects, to: featureURL.appendingPathComponent("\(name)Effects.swift"))
        try write(template.projection, to: featureURL.appendingPathComponent("\(name)Projection.swift"))
        try write(template.tests, to: featureURL.appendingPathComponent("\(name)FlowTests.swift"))

        if mode == .ai {
            try write(template.manifest, to: featureURL.appendingPathComponent("\(name).intentflow.yaml"))
        }

        print("Generated \(mode.rawValue) feature \(name) at \(featureURL.path)")
    }

    static func write(_ content: String, to url: URL) throws {
        try content.write(to: url, atomically: true, encoding: .utf8)
    }
}
