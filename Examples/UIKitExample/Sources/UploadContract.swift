import Foundation
import IntentFlow

public struct UploadPayload: Equatable, Sendable {
    public let localURL: URL
    public let bytes: Int
}

public enum UploadState: Equatable, Sendable {
    case idle
    case preparing(UploadPayload)
    case uploading(UploadPayload, progress: Double)
    case paused(UploadPayload, progress: Double)
    case failed(UploadPayload, message: String)
    case completed(remoteURL: URL)
}

public enum UploadIntent: Equatable, Sendable {
    case select(UploadPayload)
    case start
    case pause
    case retry
    case cancel
}

public enum UploadEvent: Equatable, Sendable {
    case prepared(UploadPayload)
    case progress(Double)
    case completed(URL)
    case failed(String)
}

public enum UploadEffect: Equatable, Sendable {
    case prepare(UploadPayload)
    case upload(UploadPayload)
}

public enum UploadOutput: Equatable, Sendable {
    case uploaded(URL)
    case cancelled
}

public enum UploadRoute: Equatable, Sendable {
    case documentPicker
}
