//
//  HomePageViewModel.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 05/12/24.
//

import CoreTransferable
import Foundation
import FirebaseFirestore
import PhotosUI
import SwiftUI
import UIKit

final class HomepageViewModel: ObservableObject {
    var title: String {
        (Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String) ?? ""
    }
    
    @Published var users: [User] = []
    
    private let authUseCase: AuthUseCaseProtocol
    private let userUseCase: UserUseCaseProtocol
    
    init(authUseCase: AuthUseCaseProtocol, userUseCase: UserUseCaseProtocol) {
        self.authUseCase = authUseCase
        self.userUseCase = userUseCase
    }
    
    func logout() {
        authUseCase.logout()
    }
    
    @MainActor
    func getUsers() async throws {
        users = try await userUseCase.getUsers()
    }
    
    func getUserViewModel(uid: String, imageURL: URL?) -> UserImageViewModel {
        let imageState: ImageState = imageURL == nil ? .empty : .preload(imageURL)
        let vm = UserImageViewModel(uid: uid, imageState: imageState, userUseCase: userUseCase)
        return vm
    }
}
