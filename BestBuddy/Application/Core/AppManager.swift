//
//  AppManager.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 07/12/24.
//

import FirebaseFirestore
import FirebaseCore

@MainActor
final class AppManager: ObservableObject {
    @Published var isUploading: Bool = false
    @Published var users: [User] = []
    private let userUseCase: UserUseCaseProtocol
    
    init(userUseCase: UserUseCaseProtocol) {
        self.userUseCase = userUseCase
        userUseCase.getUsers { [weak self] users in
            self?.users = users ?? []
        }
    }
}
