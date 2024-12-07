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
            List {
                ForEach(appManager.users) { user in
                    NavigationLink(destination: EditableCircularProfileImage(viewModel: viewModel.getUserViewModel(for: user, isUploading: $appManager.isUploading))) {
                        CellView(user: user)
                    }
                }
            }
            .navigationTitle(viewModel.title)
            
            
            .toolbar {
                Button {
                    viewModel.logout()
                } label: {
                    Image(systemName: "x.circle.fill")
                }
                
                Button {
                    // action
                } label: {
                    Image(systemName: "person.badge.plus")
                }
                
                if appManager.isUploading {
                    ProgressView()
                }
                
            }
        }
        
    }
}
