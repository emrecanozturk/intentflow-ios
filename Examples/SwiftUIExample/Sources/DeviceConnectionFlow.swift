import IntentFlow

public struct DeviceConnectionFlow: FlowReducer {
    public init() {}

    public func reduce(
        state: DeviceConnectionState,
        signal: FlowSignal<DeviceConnectionIntent, DeviceConnectionEvent>
    ) -> Next<DeviceConnectionState, DeviceConnectionEffect, DeviceConnectionOutput, DeviceConnectionRoute> {
        switch (state, signal) {
        case (.idle, .intent(.appear)),
             (.failed, .intent(.retry)):
            return .state(.scanning)
                .effect(.scanDevices, id: "device.scan", policy: .cancelInFlight)

        case (.scanning, .event(.devicesFound(let devices))) where devices.isEmpty:
            return .state(.failed(.noDevices))

        case (.scanning, .event(.devicesFound(let devices))):
            return .state(.choosingDevice(devices))

        case (.choosingDevice, .intent(.selectDevice(let device))):
            return .state(.connecting(device))
                .effect(.openConnection(device), id: "device.connect", policy: .cancelInFlight)

        case (.connecting, .event(.connectionOpened(let device))):
            return .state(.verifyingInternet(device))
                .effect(.verifyInternet(device), id: "device.internet", policy: .cancelInFlight)

        case (.connecting, .event(.trustMissing(let device))):
            return .state(.waitingForTrust(device))
                .route(.trustInstructions(deviceName: device.name))

        case (.verifyingInternet, .event(.internetVerified(let session))):
            return .state(.ready(session))
                .output(.sessionReady(session))

        case (_, .event(.failed(let failure))):
            return .state(.failed(failure))

        case (_, .intent(.disconnect)):
            return .state(.idle)
                .cancel("device.scan")
                .cancel("device.connect")
                .cancel("device.internet")
                .effect(.closeSession)
                .output(.sessionClosed)

        default:
            return .state(state)
        }
    }
}
