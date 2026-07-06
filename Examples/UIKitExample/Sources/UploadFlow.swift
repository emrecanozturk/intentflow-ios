import IntentFlow

public struct UploadFlow: FlowReducer {
    public init() {}

    public func reduce(
        state: UploadState,
        signal: FlowSignal<UploadIntent, UploadEvent>
    ) -> Next<UploadState, UploadEffect, UploadOutput, UploadRoute> {
        switch (state, signal) {
        case (.idle, .intent(.start)):
            return .state(.idle)
                .route(.documentPicker)

        case (_, .intent(.select(let payload))):
            return .state(.preparing(payload))
                .effect(.prepare(payload), id: "upload.prepare", policy: .cancelInFlight)

        case (.preparing, .event(.prepared(let payload))),
             (.failed(let payload, _), .intent(.retry)),
             (.paused(let payload, _), .intent(.retry)):
            return .state(.uploading(payload, progress: 0))
                .effect(.upload(payload), id: "upload.stream", policy: .cancelInFlight)

        case (.uploading(let payload, _), .event(.progress(let progress))):
            return .state(.uploading(payload, progress: progress))

        case (.uploading, .event(.completed(let url))):
            return .state(.completed(remoteURL: url))
                .output(.uploaded(url))

        case (.uploading(let payload, let progress), .intent(.pause)):
            return .state(.paused(payload, progress: progress))
                .cancel("upload.stream")

        case (.uploading(let payload, _), .event(.failed(let message))):
            return .state(.failed(payload, message: message))

        case (_, .intent(.cancel)):
            return .state(.idle)
                .cancel("upload.prepare")
                .cancel("upload.stream")
                .output(.cancelled)

        default:
            return .state(state)
        }
    }
}
