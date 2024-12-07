//
//  FirestoreService.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 04/12/24.
//
import FirebaseFirestore

protocol FirestoreServiceProtocol {
    func getUsers(completion: @escaping (([User]?) -> Void))
}

final class FirestoreService: FirestoreServiceProtocol {
    private let userCollection: CollectionReference = Firestore.firestore().collection("USERS")
    
    func getUsers(completion: @escaping (([User]?) -> Void)) {
        let db = Firestore.firestore()
        db.collection("USERS")
            .whereField("gender", isEqualTo: 0)
            .order(by: "rating", descending: true)
            .order(by: "price")
            .order(by: "active", descending: true)
            .addSnapshotListener { [weak self] (snapshot, error) in
            guard let self
            else {
                return
            }
            switch (snapshot, error) {
            case (.none, .none):
                completion([])
            case (.none, .some(let error)):
                completion([])
            case (.some(let snapshot), _):
                let users = snapshot.documents.compactMap { (document) -> User? in
                    var user: User? = try? document.data(as: User.self)
                    user?.uid = document.documentID
                    return user
                }
                completion(users)
            }
        }
    }
}
