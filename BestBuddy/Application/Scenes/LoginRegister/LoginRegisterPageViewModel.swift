//
//  LoginRegisterPageViewModel.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 04/12/24.
//

import Foundation

final class LoginRegisterPageViewModel: ObservableObject {
    
    private let authUseCase: AuthUseCaseProtocol
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    
    init(authUseCase: AuthUseCaseProtocol) {
        self.authUseCase = authUseCase
    }
    
    func onLoginButtonTapped() {
        isLoading = true
        authUseCase.login(email: email, password: password)
    }
    
    func onRegisterButtonTapped() {
        isLoading = true
        authUseCase.register(email: email, password: password)
    }
}
