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
    @StateObject var authManager: AppManager
    
    init() {
        FirebaseApp.configure()
        let appManager = AppManager()
        _authManager = StateObject(wrappedValue: appManager)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var authManager: AppManager

    var body: some View {
        if authManager.authState != .signedOut {
            HomePageView()
        } else {
            LoginRegisterPageView()
        }
    }
}
