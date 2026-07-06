import Foundation

public enum IntentFlowMode: String, Codable, Equatable, Sendable {
    case core
    case ai
}

public struct FlowManifest: Codable, Equatable, Sendable {
    public var schemaVersion: String
    public var feature: String
    public var mode: IntentFlowMode
    public var summary: String
    public var states: [String]
    public var intents: [String]
    public var events: [String]
    public var effects: [String]
    public var routes: [String]
    public var outputs: [String]
    public var invariants: [String]
    public var acceptanceTraces: [String]

    public init(
        schemaVersion: String = "0.1",
        feature: String,
        mode: IntentFlowMode,
        summary: String,
        states: [String],
        intents: [String],
        events: [String],
        effects: [String],
        routes: [String],
        outputs: [String],
        invariants: [String],
        acceptanceTraces: [String]
    ) {
        self.schemaVersion = schemaVersion
        self.feature = feature
        self.mode = mode
        self.summary = summary
        self.states = states
        self.intents = intents
        self.events = events
        self.effects = effects
        self.routes = routes
        self.outputs = outputs
        self.invariants = invariants
        self.acceptanceTraces = acceptanceTraces
    }
}
