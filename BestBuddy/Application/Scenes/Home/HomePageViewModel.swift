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
    
    func getUserViewModel(for user: User, isUploading: Binding<Bool>) -> UserImageViewModel {
        let imageState: ImageState = .preload(user.imagePath())
        let vm = UserImageViewModel(uid: user.uid ?? "", imageState: imageState, userUseCase: userUseCase, isUploading: isUploading)
        return vm
    }
}
