//
//  AuthUseCase.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 04/12/24.
//

protocol AuthUseCaseProtocol {
    func login(email: String, password: String)
    func register(email: String, password: String)
    func logout()
}

final class AuthUseCase: AuthUseCaseProtocol {
    
    private let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func login(email: String, password: String) {
        repository.login(email: email, password: password)
    }
    
    func register(email: String, password: String){
        repository.register(email: email, password: password)
    }
    
    func logout() {
        repository.logout()
    }
    
    
}
