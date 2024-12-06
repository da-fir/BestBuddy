//
//  UserUseCase.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 06/12/24.
//

import UIKit

protocol UserUseCaseProtocol {
    func getUsers() async throws -> [User]
    func addUser(user: User) async throws
    func deleteUser(uid: String) async throws
    func getUser(uid: String) async throws -> User?
    func uploadImage(image: UIImage, for uid: String,
                     completion: @escaping ((String?,  Error?) -> Void))
}

final class UserUseCase: UserUseCaseProtocol {
    private let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    func getUsers() async throws -> [User] {
        try await repository.getUsers()
    }
    
    func addUser(user: User) async throws {
        try await repository.addUser(user: user)
    }
    
    func deleteUser(uid: String) async throws {
        try await repository.deleteUser(uid: uid)
    }
    
    func getUser(uid: String) async throws -> User? {
        try await repository.getUser(uid: uid)
    }
    
    func uploadImage(image: UIImage, for uid: String, completion: @escaping ((String?,  Error?) -> Void)) {
        guard let imageData = image.jpegData(compressionQuality: 0.75)
        else { return }
        repository.uploadImage(imageData: imageData, for: uid, completion: completion)
    }
}
