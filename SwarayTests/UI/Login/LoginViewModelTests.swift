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
    
    let vmWithMockAuth = LoginViewModel(signInManager: SignInManager(authService: MockAuthService()))
    
    func testValidateEmail() {
        let viewModel = vmWithMockAuth
        
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
        let viewModel = vmWithMockAuth
        
        viewModel.password.value = "passw"
        XCTAssertFalse(viewModel.validatePassword())
        
        viewModel.password.value = ""
        XCTAssertFalse(viewModel.validatePassword())
        
        viewModel.password.value = "password"
        XCTAssertTrue(viewModel.validatePassword())
    }
    
    func testValidatedPasswordMatch() {
        let viewModel = vmWithMockAuth
        
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
        let viewModel = vmWithMockAuth
        
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
        let viewModel = vmWithMockAuth
        
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
        let viewModel = vmWithMockAuth
        
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
        let viewModel = LoginViewModel(signInManager: SignInManager(authService: mockAuthService))
        
        viewModel.login(email: "e", password: "p")
        
        let authError = viewModel.authError.value!
        XCTAssertEqual(desc, authError.description, eg(desc, authError.description))
        XCTAssertEqual(StringConsts.loginErrorTitle, authError.title, eg(StringConsts.loginErrorTitle, authError.title))
    }
    
    func testSignUpFailure_emailInUse() {
        signUpFailureTest(errorCode: .emailAlreadyInUse, desc: StringConsts.emailInUseError)
    }
    
    func testSignUpFailure_generic() {
        signUpFailureTest(errorCode: .appNotAuthorized, desc: StringConsts.genericSignUpError)
    }
    
    func signUpFailureTest(errorCode: AuthErrorCode, desc: String) {
        let mockAuthService = MockAuthServiceError(errorCode: errorCode)
        let viewModel = LoginViewModel(signInManager: SignInManager(authService: mockAuthService))
        
        viewModel.createUser(email: "e", password: "p")
        
        let authError = viewModel.authError.value!
        XCTAssertEqual(desc, authError.description, eg(desc, authError.description))
        XCTAssertEqual(StringConsts.signUpErrorTitle, authError.title, eg(StringConsts.signUpErrorTitle, authError.title))
    }

    
    func testCreateUserSuccess() {
        let successResult = AuthResult(provider: .creation, email: "success@email.com")
        let mockAuthService = MockAuthServiceSuccess(result: successResult)
        let viewModel = LoginViewModel(signInManager: SignInManager(authService: mockAuthService))
        
        viewModel.createUser(email: "e", password: "p")
        XCTAssertEqual("success@email.com", viewModel.authSuccess.value?.email, eg("success@email.com", viewModel.authSuccess.value?.email))
    }
    
    func testLoginSuccess() {
        let successResult = AuthResult(provider: .creation, email: "success@email.com")
        let mockAuthService = MockAuthServiceSuccess(result: successResult)
        let viewModel = LoginViewModel(signInManager: SignInManager(authService: mockAuthService))
        
        viewModel.login(email: "e", password: "p")
        XCTAssertEqual("success@email.com", viewModel.authSuccess.value?.email, eg("success@email.com", viewModel.authSuccess.value?.email))
    }

    func testValidateLogin_invalidEmail() {
        let viewModel = vmWithMockAuth
        viewModel.email.value = "invalid"
        let result = viewModel.validateLogin()
        XCTAssertEqual(1, viewModel.emailValidation.value, eg(1, viewModel.emailValidation.value))
        XCTAssertFalse(result)
    }
    
    func testValidateLogin_valid() {
        let viewModel = vmWithMockAuth
        viewModel.email.value = "valid@email.com"
        let result = viewModel.validateLogin()
        XCTAssertEqual(0, viewModel.emailValidation.value, eg(0, viewModel.emailValidation.value))
        XCTAssertTrue(result)
    }
    
    func testDelegateAuthing() {
        let viewModel = vmWithMockAuth
        XCTAssertFalse(viewModel.authingTrigger.value)
        viewModel.authing()
        XCTAssertTrue(viewModel.authingTrigger.value)
    }
    
    func testDelegateAuthError_fromFacebook() {
        let viewModel = vmWithMockAuth
        viewModel.authError(error: .invalidAppCredential, from: .facebook)
        let authError = viewModel.authError.value!
        
        XCTAssertEqual(StringConsts.loginErrorTitle, authError.title, eg(StringConsts.loginErrorTitle, authError.title))
        XCTAssertEqual(StringConsts.facebookSignInError, authError.description, eg(StringConsts.facebookSignInError, authError.description))
    }
    
    func testDelegateAuthError_fromGoogle() {
        let viewModel = vmWithMockAuth
        viewModel.authError(error: .invalidAppCredential, from: .google)
        let authError = viewModel.authError.value!
        
        XCTAssertEqual(StringConsts.loginErrorTitle, authError.title, eg(StringConsts.loginErrorTitle, authError.title))
        XCTAssertEqual(StringConsts.googleSignInError, authError.description, eg(StringConsts.googleSignInError, authError.description))
    }
    
    func testDelegateAuthError_fromCreation() {
        let viewModel = vmWithMockAuth
        viewModel.authError(error: .invalidAppCredential, from: .creation)
        let authError = viewModel.authError.value!
        
        XCTAssertEqual(StringConsts.signUpErrorTitle, authError.title, eg(StringConsts.signUpErrorTitle, authError.title))
        XCTAssertEqual(StringConsts.genericSignUpError, authError.description, eg(StringConsts.genericSignUpError, authError.description))
    }
    
    func testDelegateAuthError_fromLogin() {
        let viewModel = vmWithMockAuth
        viewModel.authError(error: .invalidAppCredential, from: .login)
        let authError = viewModel.authError.value!
        
        XCTAssertEqual(StringConsts.loginErrorTitle, authError.title, eg(StringConsts.loginErrorTitle, authError.title))
        XCTAssertEqual(StringConsts.genericLoginError, authError.description, eg(StringConsts.genericLoginError, authError.description))
    }
    
    func testDelegateSignInError_facebook() {
        let viewModel = vmWithMockAuth
        viewModel.signInError(error: NSError(), from: .facebook)
        let authError = viewModel.authError.value!
        
        XCTAssertEqual(StringConsts.loginErrorTitle, authError.title, eg(StringConsts.loginErrorTitle, authError.title))
        XCTAssertEqual(StringConsts.facebookSignInError, authError.description, eg(StringConsts.facebookSignInError, authError.description))
    }
    
    func testDelegateSignInError_google() {
        let viewModel = vmWithMockAuth
        viewModel.signInError(error: NSError(), from: .facebook)
        let authError = viewModel.authError.value!
        
        XCTAssertEqual(StringConsts.loginErrorTitle, authError.title, eg(StringConsts.loginErrorTitle, authError.title))
        XCTAssertEqual(StringConsts.facebookSignInError, authError.description, eg(StringConsts.facebookSignInError, authError.description))
    }
    
    func testDelegateSignInError_appLogin() {
        let viewModel = vmWithMockAuth
        viewModel.signInError(error: NSError(), from: .login)
        let authError = viewModel.authError.value!
        
        XCTAssertEqual(StringConsts.loginErrorTitle, authError.title, eg(StringConsts.loginErrorTitle, authError.title))
        XCTAssertEqual(StringConsts.genericLoginError, authError.description, eg(StringConsts.genericLoginError, authError.description))
    }
}
