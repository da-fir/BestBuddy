//
//  FirebaseAuthService.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 04/12/24.
//

protocol FirebaseAuthServiceProtocol {
    func login(username: String, password: String) -> Any
    func register(username: String, password: String) -> Any
}

final class FirebaseAuthService: FirebaseAuthServiceProtocol {
    func login(username: String, password: String) -> Any {
        return ""
    }
    
    func register(username: String, password: String) -> Any {
        return ""
    }
    
    
}
