//
//  FirestoreService.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 04/12/24.
//
import FirebaseFirestore

protocol FirestoreServiceProtocol {
    func getUsers() async throws -> [User]
    func addUser(user: User) async throws
    func deleteUser(uid: String) async throws
    func getUser(uid: String) async throws -> User?
}

final class FirestoreService: FirestoreServiceProtocol {
    private let userCollection: CollectionReference = Firestore.firestore().collection("USERS")
    
    func getUsers() async throws -> [User]  {
        return try await userCollection.getDocuments().documents.compactMap { (document) -> User? in
            var user: User? = try? document.data(as: User.self)
            user?.uid = document.documentID
            return user
        }
    }
    
    func addUser(user: User) async throws {
        try await userCollection.addDocument(data: user.asDictionary())
    }
    
    func deleteUser(uid: String) async throws {
        try await userCollection.document(uid).delete()
    }
    
    func getUser(uid: String) async throws -> User? {
        return try await userCollection.document(uid).getDocument().data(as: User.self)
    }
}

private extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
