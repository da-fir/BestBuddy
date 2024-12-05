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
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            self?.handleAuthResult(with: authResult, error: error as? NSError)
        }
    }
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            self?.handleAuthResult(with: authResult, error: error as? NSError)
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
    
    private func handleAuthResult(with result: AuthDataResult?, error: NSError?) {
        if let error {
            switch AuthErrorCode(rawValue: error.code) {
            case .operationNotAllowed:
                break
                // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
            case .emailAlreadyInUse:
                break
                // Error: The email address is already in use by another account.
            case .invalidEmail:
                break
                // Error: The email address is badly formatted.
            case .weakPassword:
                break
                // Error: The password must be 6 characters long or more.
            default:
                print("Error: \(error.localizedDescription)")
            }
        }
        else {
            // TODO: Darul
        }
    }
}
