import Foundation
import Combine

final class BeforeLoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    var onCompleted: ((String) -> Void)?
    var onTwoFactor: (() -> Void)?

    private let api: AuthAPI

    init(api: AuthAPI) {
        self.api = api
    }

    func submit() {
        guard email.contains("@") else {
            errorMessage = "Invalid email."
            return
        }

        isLoading = true
        errorMessage = nil

        api.login(email: email, password: password) { [weak self] result in
            guard let self else {
                return
            }

            self.isLoading = false
            switch result {
            case .success(let response):
                if response.requiresTwoFactor {
                    self.onTwoFactor?()
                } else {
                    self.onCompleted?(response.userID)
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

protocol AuthAPI {
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void)
}

struct LoginResponse {
    let userID: String
    let requiresTwoFactor: Bool
}
