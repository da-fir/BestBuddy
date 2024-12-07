//
//  ContentView.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 02/12/24.
//
import Foundation
import PhotosUI
import SwiftUI

struct HomePageView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appManager: AppManager
    @ObservedObject var viewModel = HomepageViewModel(
        authUseCase: AuthUseCase(
            repository: AuthRepository(
                firebaseAuthService: FirebaseAuthService()
            )
        ),
        userUseCase: UserUseCase(
            repository: UserRepository(
                firestoreService: FirestoreService(),
                storageService: FirebaseStorageService()
            )
        )
    )
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(
                    columns: [GridItem(spacing: 8), GridItem(spacing: 8)],
                    spacing: 8
                ) {
                    ForEach(appManager.users) { user in
                        NavigationLink(destination: EditableCircularProfileImage(viewModel: viewModel.getUserViewModel(for: user, isUploading: $appManager.isUploading))) {
                            CellView(user: user)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(viewModel.title)
            
            
            .toolbar {
                Button {
                    viewModel.logout()
                } label: {
                    Image(systemName: "x.circle.fill")
                }
                
                Button {
                    appManager.isDarkMode.toggle()
                } label: {
                    appManager.isDarkMode ? Image(systemName: "moon.fill") : Image(systemName: "moon")
                    
                }
                
                if appManager.isUploading {
                    ProgressView()
                }
            }
        }
        
    }
}
