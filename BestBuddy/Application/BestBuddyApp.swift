//
//  BestBuddyApp.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 02/12/24.
//

import FirebaseCore
import FirebaseAuth
import SwiftUI

@main
struct BestBuddyApp: App {
    @StateObject var authManager: AuthManager
    
    init() {
        FirebaseApp.configure()
        let authManager = AuthManager()
        _authManager = StateObject(wrappedValue: authManager)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        if authManager.authState != .signedOut {
            HomePageView()
        } else {
            LoginRegisterPageView()
        }
    }
}

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
class AuthManager: ObservableObject {
    @Published var user: FirebaseAuth.User?
    @Published var authState = AuthState.signedOut
    
    private var authStateHandle: AuthStateDidChangeListenerHandle?

    init() {
        // 3.
        configureAuthStateChanges()
    }

    // 2.
    func configureAuthStateChanges() {
        authStateHandle = Auth.auth().addStateDidChangeListener { auth, user in
            print("Auth changed: \(user != nil)")
            self.updateState(user: user)
        }
    }

    // 2.
    func removeAuthStateListener() {
        if let authStateHandle {
            Auth.auth().removeStateDidChangeListener(authStateHandle)
        }
    }

    // 4.
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
