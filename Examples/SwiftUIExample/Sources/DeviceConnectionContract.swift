import Foundation
import IntentFlow

public struct LabDevice: Equatable, Identifiable, Sendable {
    public let id: String
    public let name: String
    public let osVersion: String
    public let isTrusted: Bool
}

public struct DeviceSession: Equatable, Sendable {
    public let deviceID: String
    public let startedAt: Date
}

public enum DeviceConnectionState: Equatable, Sendable {
    case idle
    case scanning
    case choosingDevice([LabDevice])
    case connecting(LabDevice)
    case waitingForTrust(LabDevice)
    case verifyingInternet(LabDevice)
    case ready(DeviceSession)
    case failed(DeviceConnectionFailure)
}

public enum DeviceConnectionFailure: Equatable, Sendable {
    case noDevices
    case trustRequired(deviceName: String)
    case connectionLost
    case internetUnavailable
}

public enum DeviceConnectionIntent: Equatable, Sendable {
    case appear
    case selectDevice(LabDevice)
    case retry
    case disconnect
}

public enum DeviceConnectionEvent: Equatable, Sendable {
    case devicesFound([LabDevice])
    case connectionOpened(LabDevice)
    case trustMissing(LabDevice)
    case internetVerified(DeviceSession)
    case failed(DeviceConnectionFailure)
}

public enum DeviceConnectionEffect: Equatable, Sendable {
    case scanDevices
    case openConnection(LabDevice)
    case verifyInternet(LabDevice)
    case closeSession
}

public enum DeviceConnectionOutput: Equatable, Sendable {
    case sessionReady(DeviceSession)
    case sessionClosed
}

public enum DeviceConnectionRoute: Equatable, Sendable {
    case trustInstructions(deviceName: String)
}
