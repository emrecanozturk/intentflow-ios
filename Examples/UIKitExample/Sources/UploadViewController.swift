import UIKit
import IntentFlow

public final class UploadViewController: UIViewController {
    private let store: FlowStore<UploadFlow, UploadEffects>
    private let projection = UploadProjection()
    private var observation: FlowObservation?
    private var bindTask: Task<Void, Never>?

    private let titleLabel = UILabel()
    private let progressView = UIProgressView(progressViewStyle: .default)
    private let primaryButton = UIButton(type: .system)

    public init(
        store: FlowStore<UploadFlow, UploadEffects> = FlowStore(
            initialState: .idle,
            reducer: UploadFlow(),
            effects: UploadEffects()
        )
    ) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        observation?.cancel()
        bindTask?.cancel()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }

    private func configureView() {
        view.backgroundColor = .systemBackground
        primaryButton.addTarget(self, action: #selector(primaryTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [titleLabel, progressView, primaryButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func bind() {
        bindTask = Task { [weak self] in
            guard let self else {
                return
            }

            let observation = await store.observe { [weak self] snapshot in
                Task { @MainActor [weak self] in
                    self?.render(snapshot.state)
                }
            }

            self.observation = observation
            await MainActor.run {
                self.render(.idle)
            }
        }
    }

    @objc private func primaryTapped() {
        Task { [weak store] in
            await store?.send(.start)
        }
    }

    @MainActor
    private func render(_ state: UploadState) {
        let viewState = projection.project(state)
        titleLabel.text = viewState.title
        progressView.progress = Float(viewState.progress)
        primaryButton.setTitle(viewState.primaryActionTitle, for: .normal)
    }
}
