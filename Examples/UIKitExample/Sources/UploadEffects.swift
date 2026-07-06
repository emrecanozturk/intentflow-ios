import Foundation
import IntentFlow

public struct UploadEffects: FlowEffectHandler {
    public init() {}

    public func handle(_ effect: UploadEffect) -> AsyncStream<UploadEvent> {
        AsyncStream { continuation in
            let task = Task {
                switch effect {
                case .prepare(let payload):
                    try? await Task.sleep(for: .milliseconds(150))
                    continuation.yield(.prepared(payload))

                case .upload:
                    for step in 1...10 {
                        if Task.isCancelled {
                            break
                        }
                        try? await Task.sleep(for: .milliseconds(100))
                        continuation.yield(.progress(Double(step) / 10))
                    }
                    continuation.yield(.completed(URL(string: "https://example.com/uploaded/file")!))
                }

                continuation.finish()
            }

            continuation.onTermination = { _ in
                task.cancel()
            }
        }
    }
}
