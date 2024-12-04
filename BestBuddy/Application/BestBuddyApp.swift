//
//  BestBuddyApp.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 02/12/24.
//

import SwiftUI

@main
struct BestBuddyApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
