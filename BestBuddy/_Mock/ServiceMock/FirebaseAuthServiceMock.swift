//
//  FirebaseAuthServiceMock.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 04/12/24.
//

final class FirebaseAuthServiceMock: FirebaseAuthServiceProtocol {
    func login(username: String, password: String) -> Any {
        return ""
    }
    
    func register(username: String, password: String) -> Any {
        return ""
    }
}
