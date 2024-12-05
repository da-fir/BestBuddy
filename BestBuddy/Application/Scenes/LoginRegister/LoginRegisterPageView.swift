//
//  LoginRegisterPageView.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 05/12/24.
//

import SwiftUI

struct LoginRegisterPageView: View {
    @ObservedObject var viewModel: LoginRegisterPageViewModel = LoginRegisterPageViewModel(authUseCase: AuthUseCase(repository: AuthRepository(firebaseAuthService: FirebaseAuthService())))
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    TextField(
                        "Email",
                        text: $viewModel.email
                    )
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity, maxHeight: 48)
                    
                    SecureField(
                        "Password",
                        text: $viewModel.password
                    )
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity, maxHeight: 48)
                }
                
                Spacer()
                
                VStack {
                    if viewModel.isLoading {
                        ProgressView {
                            Text("Loading")
                                .foregroundColor(.accentColor)
                                .bold()
                        }
                    }
                    else {
                        Button(
                            action: viewModel.onLoginButtonTapped,
                            label: {
                                Text("Login as Admin")
                                    .font(.system(size: 24, weight: .bold, design: .default))
                                    .frame(maxWidth: .infinity, maxHeight: 48)
                                    .foregroundColor(Color.white)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                        )
                        
                        Button(
                            action: viewModel.onRegisterButtonTapped,
                            label: {
                                Text("Tap here to register as Admin")
                                    .font(.system(size: 18, weight: .bold, design: .default))
                                    .frame(maxWidth: .infinity, maxHeight: 48)
                                    .foregroundColor(Color.blue)
                            }
                        )
                    }
                }
            }
            .padding(24.0)
            .navigationTitle("Login Page")
        }
    }
}
