//
//  FirebaseStorageServiceMock.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 04/12/24.
//

import Foundation

final class FirebaseStorageServiceMock: FirebaseStorageServiceProtocol {
    func uploadImage(imageData: Data, for uid: String, completion: @escaping ((String?, (any Error)?) -> Void)) {
        
    }
    
    func uploadImage() -> Any {
        return ""
    }
    
    func getImage() -> Any {
        return ""
    }
}
