//
//  CellView.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 07/12/24.
//
import SwiftUI
import FirebaseStorage

struct CellView: View {
    @State var imageUrl: URL? = nil
    let user: User
    
    var body: some View {
        HStack {
            SmallCircleAsyncImage(imageUrl: imageUrl)
            .task {
                let ref = Storage.storage().reference(withPath: user.imagePath())
                imageUrl = try? await ref.downloadURL()
            }
            Text(user.displayString)
                .font(.system(size: 16, weight: .bold, design: .default))
        }
    }
}
