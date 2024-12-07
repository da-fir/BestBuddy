//
//  UserUseCase.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 06/12/24.
//

import UIKit

protocol UserUseCaseProtocol {
    func getUsers(completion: @escaping (([User]?) -> Void))
    func uploadImage(image: UIImage, for uid: String, completion: @escaping ((String?,  Error?) -> Void))
}

final class UserUseCase: UserUseCaseProtocol {
    private let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    func getUsers(completion: @escaping (([User]?) -> Void)) {
        repository.getUsers(completion: completion)
    }
    
    func uploadImage(image: UIImage, for uid: String, completion: @escaping ((String?,  Error?) -> Void)) {
        guard let imageData = image.jpegData(compressionQuality: 0.75)
        else { return }
        repository.uploadImage(imageData: imageData, for: uid, completion: completion)
    }
}
