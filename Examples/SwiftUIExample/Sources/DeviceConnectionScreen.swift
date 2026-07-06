import SwiftUI
import IntentFlow

@MainActor
public final class DeviceConnectionModel: ObservableObject {
    @Published public private(set) var viewState = DeviceConnectionProjection().project(.idle)

    private let store: FlowStore<DeviceConnectionFlow, DeviceConnectionEffects>
    private let projection = DeviceConnectionProjection()
    private var observation: FlowObservation?
    private var bindTask: Task<Void, Never>?

    public init(
        store: FlowStore<DeviceConnectionFlow, DeviceConnectionEffects> = FlowStore(
            initialState: .idle,
            reducer: DeviceConnectionFlow(),
            effects: DeviceConnectionEffects()
        )
    ) {
        self.store = store
    }

    deinit {
        observation?.cancel()
        bindTask?.cancel()
    }

    public func bind() {
        guard observation == nil else {
            return
        }

        bindTask = Task { [weak self] in
            guard let self else {
                return
            }

            let observation = await store.observe { [weak self] snapshot in
                Task { @MainActor [weak self] in
                    self?.viewState = self?.projection.project(snapshot.state) ?? DeviceConnectionProjection().project(.idle)
                }
            }

            self.observation = observation
            self.viewState = projection.project(await store.state)
        }
    }

    public func send(_ intent: DeviceConnectionIntent) {
        Task { [weak store] in
            await store?.send(intent)
        }
    }
}

public struct DeviceConnectionScreen: View {
    @StateObject private var model = DeviceConnectionModel()

    public init() {}

    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(model.viewState.title)
                    .font(.title.bold())
                Text(model.viewState.subtitle)
                    .foregroundStyle(.secondary)
            }

            if model.viewState.isBusy {
                ProgressView()
            }

            ForEach(model.viewState.devices) { device in
                Button {
                    model.send(.selectDevice(device))
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(device.name)
                            Text(device.osVersion)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Image(systemName: device.isTrusted ? "checkmark.shield" : "exclamationmark.triangle")
                    }
                }
            }

            if let error = model.viewState.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
            }

            if let title = model.viewState.primaryActionTitle {
                Button(title) {
                    switch title {
                    case "Disconnect":
                        model.send(.disconnect)
                    default:
                        model.send(.appear)
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .onAppear {
            model.bind()
            model.send(.appear)
        }
    }
}
