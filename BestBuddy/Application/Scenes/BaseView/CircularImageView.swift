//
//  CircularImageView.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 06/12/24.
//

import SwiftUI
import PhotosUI

struct ProfileImage: View {
    let imageState: ImageState
    
    var body: some View {
        switch imageState {
        case .preload(let path):
            BigCircleAsyncImage(path: path)
        case .success(let image):
            Image(uiImage: image).resizable()
        case .loading:
            ProgressView()
        case .empty:
            Image(systemName: "person.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
    }
}

struct CircularProfileImage: View {
    let imageState: ImageState
    
    var body: some View {
        ProfileImage(imageState: imageState)
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: 100, height: 100)
            .background {
                Circle().fill(
                    LinearGradient(
                        colors: [.yellow, .orange],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
    }
}

struct SmallCircleAsyncImage: View {
    let imageUrl: URL?
    var body: some View {
        AsyncImage(url: imageUrl, content: { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 32, maxHeight: 32)
        },
                   placeholder: { }
        )
            .frame(width: 32, height: 32)
            .background {
                Circle().fill(
                    LinearGradient(
                        colors: [.yellow, .orange],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .clipShape(Circle())
    }
}

import FirebaseStorage

struct BigCircleAsyncImage: View {
    @State var imageUrl: URL?
    let path: String
    var body: some View {
        AsyncImage(url: imageUrl, content: { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 300, maxHeight: 100)
        },
                   placeholder: {
        })
        .frame(width: 100, height: 100)
        .background {
            Circle().fill(
                LinearGradient(
                    colors: [.yellow, .orange],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .clipShape(Circle())
        .task {
            let ref = Storage.storage().reference(withPath: path)
            imageUrl = try? await ref.downloadURL()
        }
    }
}

struct EditableCircularProfileImage: View {
    @ObservedObject var viewModel: UserImageViewModel
    
    var body: some View {
        CircularProfileImage(imageState: viewModel.imageState)
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(selection: $viewModel.imageSelection,
                             matching: .images,
                             photoLibrary: .shared()) {
                    Image(systemName: "pencil.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 30))
                        .foregroundColor(.accentColor)
                }
                .buttonStyle(.borderless)
            }
    }
}

struct ProfileImageTransferable: Transferable {
    let uiImage: UIImage
    
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            guard let uiImage = UIImage(data: data) else {
                throw TransferError.importFailed
            }
            return ProfileImageTransferable(uiImage: uiImage)
        }
    }
}
