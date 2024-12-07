//
//  UserImageViewModel.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 06/12/24.
//
import SwiftUI
import PhotosUI

enum ImageState {
    case empty
    case preload(String)
    case loading(Progress)
    case success(UIImage)
    case failure(Error)
}

enum TransferError: Error {
    case importFailed
}

final class UserImageViewModel: ObservableObject {
    private let uid: String
    private let userUseCase: UserUseCaseProtocol
    @Published var imageState: ImageState = .empty
    @Binding var isUploading: Bool

    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    init(uid: String, imageState: ImageState, userUseCase: UserUseCaseProtocol, isUploading: Binding<Bool>) {
        self.uid = uid
        self.imageState = imageState
        self.userUseCase = userUseCase
        self._isUploading = isUploading
    }

    // MARK: - Private Methods

    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: ProfileImageTransferable.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                switch result {
                case .success(let profileImage?):
                    self.imageState = .success(profileImage.uiImage)
                    self.upload(profileImage.uiImage)
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
    
    private func upload(_ image: UIImage) {
        isUploading = true
        userUseCase.uploadImage(image: image, for: uid) { output, error in
            self.isUploading = false
        }
    }
}

