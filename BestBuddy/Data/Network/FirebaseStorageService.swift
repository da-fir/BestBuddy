//
//  FirebaseStorageService.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 04/12/24.
//
import FirebaseStorage

protocol FirebaseStorageServiceProtocol {
    func uploadImage(imageData: Data, for uid: String, completion: @escaping ((String?, Error?) -> Void))
}

final class FirebaseStorageService: FirebaseStorageServiceProtocol {
    func uploadImage(imageData: Data, for uid: String, completion: @escaping ((String?, Error?) -> Void)) {
        let ref = Storage.storage().reference(withPath: "/profileimages/\(uid)")
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion(nil, error)
                print("Err: Failed to upload image \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { url, error in
                guard let imageURL = url?.absoluteString else {return}
                completion(imageURL, nil)
            }
        }
    }
}
