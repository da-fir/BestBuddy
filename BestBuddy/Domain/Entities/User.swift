//
//  User.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 04/12/24.
//
import Foundation

struct User: Codable, Identifiable {
    let id: String = UUID().uuidString
    var uid: String?
    let email: String?
    let phoneNumber: String?
    let gender: Gender?
    let imageUrl: String?
    
    var displayString: String {
        (email ?? "") + " " + (gender?.text ?? "")
    }
}

enum Gender: Int, Codable {
    case male = 1
    case female = 0
    
    var text: String {
        self == .male ? "Male" : "Female"
    }
}
