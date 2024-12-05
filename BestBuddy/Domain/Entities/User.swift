//
//  User.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 04/12/24.
//
import Foundation

struct User: Codable, Identifiable {
    let id: String = UUID().uuidString
    let uid: String?
    let email: String?
    let phoneNumber: String?
    let gender: Gender?
}

enum Gender: Int, Codable {
    case male = 1
    case female = 0
}
