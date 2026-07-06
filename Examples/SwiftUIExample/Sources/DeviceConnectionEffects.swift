import Foundation
import IntentFlow

public struct DeviceConnectionEffects: FlowEffectHandler {
    public init() {}

    public func handle(_ effect: DeviceConnectionEffect) -> AsyncStream<DeviceConnectionEvent> {
        AsyncStream { continuation in
            let task = Task {
                switch effect {
                case .scanDevices:
                    try? await Task.sleep(for: .milliseconds(250))
                    continuation.yield(.devicesFound([
                        LabDevice(id: "A1", name: "iPhone 15 Pro", osVersion: "18.5", isTrusted: true),
                        LabDevice(id: "B2", name: "iPhone 14", osVersion: "17.7", isTrusted: false)
                    ]))

                case .openConnection(let device):
                    try? await Task.sleep(for: .milliseconds(250))
                    if device.isTrusted {
                        continuation.yield(.connectionOpened(device))
                    } else {
                        continuation.yield(.trustMissing(device))
                    }

                case .verifyInternet(let device):
                    try? await Task.sleep(for: .milliseconds(250))
                    continuation.yield(.internetVerified(.init(deviceID: device.id, startedAt: Date())))

                case .closeSession:
                    break
                }

                continuation.finish()
            }

            continuation.onTermination = { _ in
                task.cancel()
            }
        }
    }
}
