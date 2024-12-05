//
//  HomePageViewModel.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 05/12/24.
//


import CoreLocation
import Foundation
import FirebaseFirestore
import UIKit

final class HomepageViewModel: ObservableObject {
    var title: String {
        (Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String) ?? ""
    }
    
    private let authUseCase: AuthUseCaseProtocol
    private var documents: [DocumentSnapshot] = []
    private var listener: ListenerRegistration?
    
    var query: Query? {
        didSet {
            if let listener = listener {
                listener.remove()
                observeQuery()
            }
        }
    }
    
    func baseQuery() -> Query {
        return Firestore.firestore().collection("USERS").limit(to: 50)
    }
    
    @Published var users: [User] = []
    
    init(authUseCase: AuthUseCaseProtocol) {
        self.authUseCase = authUseCase
    }
    
    func viewDidLoad() {
        query = baseQuery()
        observeQuery()
        query = baseQuery()
        observeQuery()
    }
    
    func logout() {
        authUseCase.logout()
    }
    
    private func observeQuery() {
        guard let query = query else { return }
        stopObserving()
        
        // Display data from Firestore, part one
        
        listener = query.addSnapshotListener { [unowned self] (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results: \(error!)")
                return
            }
            let models = snapshot.documents.map { (document) -> User in
                if let model = try? document.data(as: User.self) {
                    return model
                } else {
                    return User(uid: nil, email: nil, phoneNumber: nil, gender: nil)
                }
            }
            self.users = models
            self.documents = snapshot.documents
        }
    }
    
    private func stopObserving() {
        listener?.remove()
    }
}
