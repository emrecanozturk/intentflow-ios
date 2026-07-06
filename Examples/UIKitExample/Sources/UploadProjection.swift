import Foundation
import IntentFlow

public struct UploadViewState: Equatable, Sendable {
    public let title: String
    public let progress: Double
    public let primaryActionTitle: String
}

public struct UploadProjection: FlowProjection {
    public init() {}

    public func project(_ state: UploadState) -> UploadViewState {
        switch state {
        case .idle:
            return .init(title: "Select an upload", progress: 0, primaryActionTitle: "Choose File")
        case .preparing:
            return .init(title: "Preparing", progress: 0, primaryActionTitle: "Cancel")
        case .uploading(_, let progress):
            return .init(title: "Uploading", progress: progress, primaryActionTitle: "Pause")
        case .paused(_, let progress):
            return .init(title: "Paused", progress: progress, primaryActionTitle: "Resume")
        case .failed(_, let message):
            return .init(title: message, progress: 0, primaryActionTitle: "Retry")
        case .completed:
            return .init(title: "Uploaded", progress: 1, primaryActionTitle: "Done")
        }
    }
}
