//
//  User.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 04/12/24.
//
import Foundation
import FirebaseStorage

struct User: Codable, Identifiable {
    let id: String = UUID().uuidString
    var uid: String?
    let email: String?
    let phoneNumber: String?
    let gender: Gender?
    let price: Int?
    let rating: Int?
    
    var displayString: String {
        let name: String = String(email?.split(separator: "@").first ?? "")
        return name
    }
    
    func imagePath() -> String {
        return "/profileimages/\(uid ?? "")"
    }
}

enum Gender: Int, Codable {
    case male = 1
    case female = 0
    
    var text: String {
        self == .male ? "Male" : "Female"
    }
}
