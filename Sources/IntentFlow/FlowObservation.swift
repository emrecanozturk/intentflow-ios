public final class FlowObservation: @unchecked Sendable {
    private let onCancel: @Sendable () -> Void
    private var isCancelled = false

    public init(onCancel: @escaping @Sendable () -> Void) {
        self.onCancel = onCancel
    }

    deinit {
        cancel()
    }

    public func cancel() {
        guard !isCancelled else {
            return
        }
        isCancelled = true
        onCancel()
    }
}
