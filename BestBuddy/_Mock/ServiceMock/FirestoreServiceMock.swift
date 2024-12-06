//
//  FirestoreServiceMock.swift
//  BestBuddy
//
//  Created by Darul Firmansyah on 04/12/24.
//

final class FirestoreServiceMock: FirestoreServiceProtocol {
    func getUsers() async throws -> [User] {
        return []
    }
    
    func addUser(user: User) async throws {
        
    }
    
    func deleteUser(uid: String) async throws {
        
    }
    
    func getUser(uid: String) async throws -> User? {
        return nil
    }
}
