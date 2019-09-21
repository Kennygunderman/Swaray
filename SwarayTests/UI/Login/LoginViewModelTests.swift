//
//  SignUpViewModelTest.swift
//  SwarayTests
//
//  Created by Kenny Gunderman on 9/18/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation

import XCTest
@testable import Swaray
import Firebase

class LoginViewModelTests: XCTestCase {
    
    var viewModel = LoginViewModel()
    
    func testValidateEmail() {
        viewModel.email.value = "test@test"
        XCTAssertFalse(viewModel.validateEmail())
        
        viewModel.email.value = ""
        XCTAssertFalse(viewModel.validateEmail())
        
        viewModel.email.value = "test"
        XCTAssertFalse(viewModel.validateEmail())
        
        viewModel.email.value = "~!#$$"
        XCTAssertFalse(viewModel.validateEmail())
        
        viewModel.email.value = "~!#$$@123.com"
        XCTAssertFalse(viewModel.validateEmail())
        
        viewModel.email.value = "kenny~gunderman!@gmail.com"
        XCTAssertFalse(viewModel.validateEmail())
        
        viewModel.email.value = "test@test."
        XCTAssertFalse(viewModel.validateEmail())
        
        viewModel.email.value = "~!#$@!!!.com"
        XCTAssertFalse(viewModel.validateEmail())
        
        viewModel.email.value = "test@test.com"
        XCTAssertTrue(viewModel.validateEmail())
    }
    
    func testValidatePassword() {
        viewModel.password.value = "passw"
        XCTAssertFalse(viewModel.validatePassword())
        
        viewModel.password.value = ""
        XCTAssertFalse(viewModel.validatePassword())
        
        viewModel.password.value = "password"
        XCTAssertTrue(viewModel.validatePassword())
    }
    
    func testValidatedPasswordMatch() {
        viewModel.password.value = "passw"
        viewModel.confirmPassword.value = "pass"
        XCTAssertFalse(viewModel.confirmPasswordMatch())
        
        viewModel.password.value = "password"
        viewModel.confirmPassword.value = ""
        XCTAssertFalse(viewModel.confirmPasswordMatch())
        
        viewModel.password.value = ""
        viewModel.confirmPassword.value = ""
        XCTAssertFalse(viewModel.confirmPasswordMatch())
        
        viewModel.password.value = "pass"
        viewModel.confirmPassword.value = "pass"
        XCTAssertFalse(viewModel.confirmPasswordMatch())
        
        viewModel.password.value = ""
        viewModel.confirmPassword.value = "password"
        XCTAssertFalse(viewModel.confirmPasswordMatch())
        
        viewModel.password.value = "password"
        viewModel.confirmPassword.value = "password"
        XCTAssertTrue(viewModel.confirmPasswordMatch())
    }
    
    func testValidateSignUp_invalidEmail_invalidPassword() {
        viewModel.email.value = "invalid-format-email"
        viewModel.password.value = "2shrt"
        viewModel.confirmPassword.value = "2shrt"
        
        let result = viewModel.validateSignUp()
        XCTAssertEqual(1, viewModel.emailValidation.value, eg(1, viewModel.emailValidation.value))
        XCTAssertEqual(1, viewModel.passwordValidation.value, eg(1, viewModel.passwordValidation.value))
        XCTAssertEqual(0, viewModel.pwMatchValidation.value, eg(0, viewModel.pwMatchValidation.value))
        XCTAssertFalse(result)
    }
    
    func testValidateSignUp_passwordMismatch() {
        viewModel.email.value = "validEmail@email.com"
        viewModel.password.value = "password"
        viewModel.confirmPassword.value = "pass0wrd"
        
        let result = viewModel.validateSignUp()
        XCTAssertEqual(0, viewModel.emailValidation.value, eg(0, viewModel.emailValidation.value))
        XCTAssertEqual(0, viewModel.passwordValidation.value, eg(0, viewModel.passwordValidation.value))
        XCTAssertEqual(1, viewModel.pwMatchValidation.value, eg(1, viewModel.pwMatchValidation.value))
        XCTAssertFalse(result)
    }
    
    func testValidateSignUp_valid() {
        viewModel.email.value = "validEmail@email.com"
        viewModel.password.value = "password"
        viewModel.confirmPassword.value = "password"
        
        let result = viewModel.validateSignUp()
        XCTAssertEqual(0, viewModel.emailValidation.value, eg(0, viewModel.emailValidation.value))
        XCTAssertEqual(0, viewModel.passwordValidation.value, eg(0, viewModel.passwordValidation.value))
        XCTAssertEqual(0, viewModel.pwMatchValidation.value, eg(0, viewModel.pwMatchValidation.value))
        XCTAssertTrue(result)
    }
    
    func testLoginFailure_invalidEmail() {
        loginFailureTest(errorCode: .invalidEmail, desc: StringConsts.invalidEmail)
    }
    
    func testLoginFailure_wrongPassword() {
        loginFailureTest(errorCode: .wrongPassword, desc: StringConsts.invalidPassword)
    }
    
    func testLoginFailure_invalidCredentials() {
        loginFailureTest(errorCode: .invalidCredential, desc: StringConsts.invalidCredentials)
    }
    
    func testLoginFailure_generic() {
        loginFailureTest(errorCode: .appNotAuthorized, desc: StringConsts.genericLoginError)
    }
    
    func loginFailureTest(errorCode: AuthErrorCode, desc: String) {
        let mockAuthService = MockAuthServiceError(errorCode: errorCode)
        viewModel = LoginViewModel(authService: mockAuthService)
        viewModel.login(email: "e", password: "p")
        
        let authError = viewModel.authError.value!
        XCTAssertEqual(desc, authError.description, eg(desc, authError.description))
        XCTAssertEqual(StringConsts.loginError, authError.title, eg(StringConsts.loginError, authError.title))
    }
    
    func testSignUpFailure_emailInUse() {
        signUpFailureTest(errorCode: .emailAlreadyInUse, desc: StringConsts.emailInUseError)
    }
    
    func testSignUpFailure_generic() {
        signUpFailureTest(errorCode: .appNotAuthorized, desc: StringConsts.genericSignUpError)
    }
    
    func signUpFailureTest(errorCode: AuthErrorCode, desc: String) {
        let mockAuthService = MockAuthServiceError(errorCode: errorCode)
        viewModel = LoginViewModel(authService: mockAuthService)
        viewModel.createUser(email: "e", password: "p")
        
        let authError = viewModel.authError.value!
        XCTAssertEqual(desc, authError.description, eg(desc, authError.description))
        XCTAssertEqual(StringConsts.signUpError, authError.title, eg(StringConsts.signUpError, authError.title))
    }

    
    func testCreateUserSuccess() {
        let successResult = AuthResult(email: "success@email.com")
        viewModel = LoginViewModel(authService: MockAuthServiceSuccess(result: successResult))
        viewModel.createUser(email: "e", password: "p")
        XCTAssertTrue(viewModel.authSuccess.value?.email == "success@email.com")
    }
    
    func testLoginSuccess() {
        let successResult = AuthResult(email: "success@email.com")
        viewModel = LoginViewModel(authService: MockAuthServiceSuccess(result: successResult))
        viewModel.login(email: "e", password: "p")
        XCTAssertTrue(viewModel.authSuccess.value?.email == "success@email.com")
    }

    func testValidateLogin_invalidEmail() {
        viewModel.email.value = "invalid"
        let result = viewModel.validateLogin()
        XCTAssertEqual(1, viewModel.emailValidation.value, eg(1, viewModel.emailValidation.value))
        XCTAssertFalse(result)
    }
    
    func testValidateLogin_valid() {
        viewModel.email.value = "valid@email.com"
        let result = viewModel.validateLogin()
        XCTAssertEqual(0, viewModel.emailValidation.value, eg(0, viewModel.emailValidation.value))
        XCTAssertTrue(result)
    }
}
