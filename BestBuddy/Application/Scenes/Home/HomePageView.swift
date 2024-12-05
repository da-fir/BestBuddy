//
//  ContentView.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 02/12/24.
//
import Foundation
import SwiftUI

struct HomePageView: View {
    @ObservedObject var viewModel = HomepageViewModel(authUseCase: AuthUseCase(repository: AuthRepository(firebaseAuthService: FirebaseAuthService())))
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.users) { user in
                    Text(user.email ?? "")
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
            viewModel.viewDidLoad()
        }
    }
}
