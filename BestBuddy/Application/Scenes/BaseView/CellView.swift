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
        VStack {
            HStack {
                Text(user.displayString)
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .lineLimit(1)
                    .foregroundStyle(.black)
                
                Circle().fill(
                    .green
                )
                .frame(width: 8, height: 8)
                
                Spacer()
                
                Image(uiImage: UIImage(named: "verified") ?? UIImage())
                    .frame(width: 16, height: 16)
                Image(uiImage: UIImage(named: "insta") ?? UIImage())
                    .frame(width: 16, height: 16)
            }
            
            ZStack {
                AsyncImage(url: imageUrl)
                    .frame(height: 180)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerSize: CGSize(width: 16, height: 16))
                            .foregroundStyle(.gray)
                    }
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 16, height: 16)))
                    .overlay(alignment: .bottom) {
                        HStack {
                            Image(uiImage: UIImage(named: "cod_round") ?? UIImage())
                                .resizable()
                                .frame(width: 40.0, height: 40.0)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                            Image(uiImage: UIImage(named: "ml") ?? UIImage())
                                .resizable()
                                .frame(width: 40.0, height: 40.0)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .overlay {
                                    ZStack {
                                        Circle()
                                            .opacity(0.3)
                                        Text("+3")
                                            .foregroundStyle(.black)
                                        
                                    }
                                }
                            
                            Spacer()
                            
                            Image(uiImage: UIImage(named: "sound_light") ?? UIImage())
                                .resizable()
                                .frame(width: 40.0, height: 40.0)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                            
                            
                        }
                        .offset(x: 0, y: 15)
                    }
            }
            .task {
                let ref = Storage.storage().reference(withPath: user.imagePath())
                imageUrl = try? await ref.downloadURL()
            }
            
            Color.clear
                .frame(height: 16)
                .frame(maxWidth: .infinity)
            
            VStack {
                HStack {
                    Image(uiImage: UIImage(named: "star") ?? UIImage())
                        .resizable()
                        .frame(width: 16.0, height: 16.0)
                    
                    Text("4.9")
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .lineLimit(1)
                        .foregroundStyle(.black)
                    
                    Text("(61)")
                        .font(.system(size: 16, weight: .medium, design: .monospaced))
                        .lineLimit(1)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                }
                
                HStack {
                    Image(uiImage: UIImage(named: "on_fire") ?? UIImage())
                        .resizable()
                        .frame(width: 16.0, height: 16.0)
                    
                    HStack(spacing: 0) {
                        Text("110.")
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                            .lineLimit(1)
                            .foregroundStyle(.black)
                        
                        Text("00/1Hr")
                            .font(.system(size: 12, weight: .medium, design: .monospaced))
                            .lineLimit(1)
                            .foregroundStyle(.black)
                    }
                    
                    Spacer()
                }
            }
        }
        .padding(12.0)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}
