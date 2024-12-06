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
                ForEach(viewModel.users) { user in
                    NavigationLink(destination: EditableCircularProfileImage(viewModel: viewModel.getUserViewModel(uid: user.uid ?? "", imageURL:  URL(string: user.imageUrl ?? "")))) {
                        HStack {
                            SmallCircleAsyncImage(imageUrl: URL(string: user.imageUrl ?? ""))
                            Text(user.displayString)
                                .font(.system(size: 16, weight: .bold, design: .default))
                        }
                    }
                }
            }
            .navigationTitle(viewModel.title)
            
            .toolbar {
                Button {
                    viewModel.logout()
                } label: {
                    Image(systemName: "person.circle")
                }
                
                Button {
                    // action
                } label: {
                    Image(systemName: "person.badge.plus")
                }
                
            }
        }
        .onAppear {
            Task {
                try await viewModel.getUsers()
            }
        }
        
    }
}
