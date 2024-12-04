//
//  AuthRepository.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 04/12/24.
//

protocol AuthRepositoryProtocol {
    func login(username: String, password: String) -> Any
    func register(username: String, password: String) -> Any
}

final class AuthRepository: AuthRepositoryProtocol {
    private let firebaseAuthService: FirebaseAuthServiceProtocol
    
    init(firebaseAuthService: FirebaseAuthServiceProtocol) {
        self.firebaseAuthService = firebaseAuthService
    }
    
    func login(username: String, password: String) -> Any {
        firebaseAuthService.login(username: username, password: password)
    }
    
    func register(username: String, password: String) -> Any  {
        firebaseAuthService.register(username: username, password: password)
    }
}
