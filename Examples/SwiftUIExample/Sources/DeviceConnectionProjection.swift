import Foundation
import IntentFlow

public struct DeviceConnectionViewState: Equatable, Sendable {
    public let title: String
    public let subtitle: String
    public let devices: [LabDevice]
    public let isBusy: Bool
    public let primaryActionTitle: String?
    public let errorMessage: String?
}

public struct DeviceConnectionProjection: FlowProjection {
    public init() {}

    public func project(_ state: DeviceConnectionState) -> DeviceConnectionViewState {
        switch state {
        case .idle:
            return .init(
                title: "Device Lab",
                subtitle: "Choose a device session",
                devices: [],
                isBusy: false,
                primaryActionTitle: "Scan",
                errorMessage: nil
            )

        case .scanning:
            return .init(
                title: "Scanning",
                subtitle: "Looking for trusted USB devices",
                devices: [],
                isBusy: true,
                primaryActionTitle: nil,
                errorMessage: nil
            )

        case .choosingDevice(let devices):
            return .init(
                title: "Choose Device",
                subtitle: "\(devices.count) devices available",
                devices: devices,
                isBusy: false,
                primaryActionTitle: nil,
                errorMessage: nil
            )

        case .connecting(let device):
            return .init(
                title: "Connecting",
                subtitle: device.name,
                devices: [],
                isBusy: true,
                primaryActionTitle: nil,
                errorMessage: nil
            )

        case .waitingForTrust(let device):
            return .init(
                title: "Trust Required",
                subtitle: device.name,
                devices: [],
                isBusy: false,
                primaryActionTitle: "Retry",
                errorMessage: "Trust this computer on the device, then retry."
            )

        case .verifyingInternet(let device):
            return .init(
                title: "Verifying Internet",
                subtitle: device.name,
                devices: [],
                isBusy: true,
                primaryActionTitle: nil,
                errorMessage: nil
            )

        case .ready(let session):
            return .init(
                title: "Session Ready",
                subtitle: session.deviceID,
                devices: [],
                isBusy: false,
                primaryActionTitle: "Disconnect",
                errorMessage: nil
            )

        case .failed(let failure):
            return .init(
                title: "Cannot Start Session",
                subtitle: "The flow is recoverable",
                devices: [],
                isBusy: false,
                primaryActionTitle: "Retry",
                errorMessage: failure.message
            )
        }
    }
}

private extension DeviceConnectionFailure {
    var message: String {
        switch self {
        case .noDevices:
            return "No devices were found."
        case .trustRequired(let deviceName):
            return "\(deviceName) is not trusted."
        case .connectionLost:
            return "The connection was lost."
        case .internetUnavailable:
            return "The device could not reach the internet."
        }
    }
}
