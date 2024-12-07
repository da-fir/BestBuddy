//
//  UserRepository.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 06/12/24.
//
import Foundation

protocol UserRepositoryProtocol {
    func getUsers(completion: @escaping (([User]?) -> Void))
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
    
    func getUsers(completion: @escaping (([User]?) -> Void))  {
        firestoreService.getUsers(completion: completion)
    }
    
    func uploadImage(imageData: Data, for uid: String, completion: @escaping ((String?,  Error?) -> Void)) {
        storageService.uploadImage(imageData: imageData, for: uid, completion: completion)
    }
}
