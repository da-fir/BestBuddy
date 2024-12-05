//
//  AuthRepository.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 04/12/24.
//

protocol AuthRepositoryProtocol {
    func login(email: String, password: String)
    func register(email: String, password: String)
    func logout()
}

final class AuthRepository: AuthRepositoryProtocol {
    private let firebaseAuthService: FirebaseAuthServiceProtocol
    
    init(firebaseAuthService: FirebaseAuthServiceProtocol) {
        self.firebaseAuthService = firebaseAuthService
    }
    
    func login(email: String, password: String) {
        firebaseAuthService.login(email: email, password: password)
    }
    
    func register(email: String, password: String)  {
        firebaseAuthService.register(email: email, password: password)
    }
    
    func logout() {
        firebaseAuthService.logout()
    }
}
