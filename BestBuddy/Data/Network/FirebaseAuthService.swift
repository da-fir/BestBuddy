//
//  FirebaseAuthService.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 04/12/24.
//
import FirebaseAuth
import FirebaseCore

protocol FirebaseAuthServiceProtocol {
    func login(email: String, password: String)
    func register(email: String, password: String)
    func logout()
}

final class FirebaseAuthService: FirebaseAuthServiceProtocol {
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            // no op
        }
    }
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            // no op
        }
    }
    
    func logout() {
        if let _ = Auth.auth().currentUser {
            do {
                try Auth.auth().signOut()
            }
            catch let error as NSError {
                print("FirebaseAuthError: failed to sign out from Firebase, \(error)")
            }
        }
    }
}
