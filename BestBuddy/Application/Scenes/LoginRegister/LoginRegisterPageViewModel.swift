//
//  LoginRegisterPageViewModel.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 04/12/24.
//

import Foundation

final class LoginRegisterPageViewModel: ObservableObject {
    
    private let authUseCase: AuthUseCaseProtocol
    private var username: String = ""
    private var password: String = ""
    var result: User?
    
    init(authUseCase: AuthUseCaseProtocol) {
        self.authUseCase = authUseCase
    }
    
    func onLoginButtonTapped() {
        result = authUseCase.login(username: username, password: password)
    }
    
    func onRegisterButtonTapped() {
        result = authUseCase.register(username: username, password: password)
    }
}
