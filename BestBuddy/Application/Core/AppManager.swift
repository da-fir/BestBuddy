//
//  AppManager.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 07/12/24.
//


// TODO: Darul

import AuthenticationServices
import FirebaseAuth
import FirebaseCore

enum AuthState {
    case authenticated // Anonymously authenticated in Firebase.
    case signedIn // Authenticated in Firebase using one of service providers, and not anonymous.
    case signedOut // Not authenticated in Firebase.
}

@MainActor
class AppManager: ObservableObject {
    @Published var user: FirebaseAuth.User?
    @Published var authState = AuthState.signedOut
    
    private var authStateHandle: AuthStateDidChangeListenerHandle?

    init() {
        authStateHandle = Auth.auth().addStateDidChangeListener { auth, user in
            self.updateState(user: user)
        }
    }
    
    func updateState(user: FirebaseAuth.User?) {
        self.user = user
        let isAuthenticatedUser = user != nil

        if isAuthenticatedUser {
            self.authState = .signedIn
        } else {
            self.authState = .signedOut
        }
    }
}
