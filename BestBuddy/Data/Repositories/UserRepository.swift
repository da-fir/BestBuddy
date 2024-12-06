//
//  UserRepository.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 06/12/24.
//
import Foundation

protocol UserRepositoryProtocol {
    func getUsers() async throws -> [User]
    func addUser(user: User) async throws
    func deleteUser(uid: String) async throws
    func getUser(uid: String) async throws -> User?
    func uploadImage(imageData: Data, for uid: String, completion: @escaping ((String?,  Error?) -> Void))
}

final class UserRepository: UserRepositoryProtocol {
    private let firestoreService: FirestoreServiceProtocol
    private let storageService: FirebaseStorageServiceProtocol
    
    init(
        firestoreService: FirestoreServiceProtocol,
        storageService: FirebaseStorageServiceProtocol
    ) {
        self.firestoreService = firestoreService
        self.storageService = storageService
    }
    
    func getUsers() async throws -> [User] {
        try await firestoreService.getUsers()
    }
    
    func addUser(user: User) async throws {
        try await firestoreService.addUser(user: user)
    }
    
    func deleteUser(uid: String) async throws {
        try await firestoreService.deleteUser(uid: uid)
    }
    
    func getUser(uid: String) async throws -> User? {
        try await firestoreService.getUser(uid: uid)
    }
    
    func uploadImage(imageData: Data, for uid: String, completion: @escaping ((String?,  Error?) -> Void)) {
        storageService.uploadImage(imageData: imageData, for: uid, completion: completion)
    }
}
