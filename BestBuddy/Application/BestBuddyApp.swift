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
    @StateObject var appManager: AppManager
    @StateObject var authManager: AuthManager
    
    init() {
        FirebaseApp.configure()
        let authManager = AuthManager()
        let appManager = AppManager(userUseCase: UserUseCase(repository: UserRepository(firestoreService: FirestoreService(), storageService: FirebaseStorageService())))
        _appManager = StateObject(wrappedValue: appManager)
        _authManager = StateObject(wrappedValue: authManager)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appManager)
                .environmentObject(authManager)
                .preferredColorScheme(appManager.isDarkMode ? .dark : .light)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var authManger: AuthManager

    var body: some View {
        mainView()
    }
    
    @ViewBuilder
    func mainView() -> some View {
        if authManger.authState != .signedOut {
            HomePageView()
        }
        else {
            LoginRegisterPageView()
        }
    }
}
