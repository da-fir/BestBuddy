//
//  AuthUseCase.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 04/12/24.
//

protocol AuthUseCaseProtocol {
    func login(username: String, password: String) -> User?
    func register(username: String, password: String) -> User?
}

final class AuthUseCase: AuthUseCaseProtocol {
    
    private let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func login(username: String, password: String) -> User? {
        repository.login(username: username, password: password) as? User
    }
    
    func register(username: String, password: String) -> User? {
        repository.register(username: username, password: password) as? User
    }
    
    
}
