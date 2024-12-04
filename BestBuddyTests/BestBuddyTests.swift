//
//  BestBuddyTests.swift
//  BestBuddyTests
//
//  Created by Darul Firmansyah on 02/12/24.
//

@testable import BestBuddy
import XCTest

final class LoginRegisterPageViewModelTests: XCTestCase {
    var sut: LoginRegisterPageViewModel!
    var authuseCase: AuthUseCase!
    var authRepository: AuthRepository!
    var firebaseAuthService: FirebaseAuthServiceMock!
    
    override func setUpWithError() throws {
        firebaseAuthService = FirebaseAuthServiceMock()
        authRepository = AuthRepository(firebaseAuthService: firebaseAuthService)
        authuseCase = AuthUseCase(repository: authRepository)
        sut = LoginRegisterPageViewModel(authUseCase: authuseCase)
    }

    override func tearDownWithError() throws {
        firebaseAuthService = nil
        authRepository = nil
        authuseCase = nil
        sut = nil
    }

    func testLogin() throws {
        sut.onLoginButtonTapped()
        XCTAssertNil(sut.result)
    }
    
    func testRegister() throws {
        sut.onRegisterButtonTapped()
        XCTAssertNil(sut.result)
    }

}
