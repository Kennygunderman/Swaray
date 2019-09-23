//
//  SignUpViewModel.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/15/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import Bond
import Firebase

class LoginViewModel {
    let email = Observable<String?>("")
    let password = Observable<String?>("")
    let confirmPassword = Observable<String?>("")
    
    let emailValidation = Observable<CGFloat>(0)
    let passwordValidation = Observable<CGFloat>(0)
    let pwMatchValidation = Observable<CGFloat>(0)
    
    let authError = Observable<AuthError?>(nil)
    let authSuccess = Observable<AuthResult?>(nil)
    
    private let authService: AuthServiceInterface
    
    init(authService: AuthServiceInterface = getAuthService()) {
        self.authService = authService
    
        _ = email.observeNext { _ in
            if self.emailValidation.value == 1 {
                if (self.validateEmail()) {
                    self.emailValidation.value = 0
                }
            }
        }
        
        _ = password.observeNext { _ in
            if (self.confirmPasswordMatch()) {
                self.pwMatchValidation.value = 0
            }
            
            if self.passwordValidation.value == 1 {
                if (self.validatePassword()) {
                    self.passwordValidation.value = 0
                }
            }
        }

        _ = confirmPassword.observeNext { _ in
            if (self.confirmPasswordMatch()) {
                self.pwMatchValidation.value = 0
            }
        }
    }
    
    func validateEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email.value ?? "")
    }
    
    // Password must be atleast 6 characters
    func validatePassword() -> Bool {
        return password.value?.count ?? 0 >= 6
    }
    
    func confirmPasswordMatch() -> Bool {
        return password.value == confirmPassword.value && validatePassword()
    }
    
    func validateLogin() -> Bool {
        let validated = validateEmail()
        if (!validated) {
            emailValidation.value = 1
        }
        return validated
    }
    
    func validateSignUp() -> Bool {
        var validated = true
        
        if (!validateEmail()) {
            emailValidation.value = 1
            validated = false
        }
        
        if (!validatePassword()) {
            passwordValidation.value = 1
            return false
        }
        
        if (!confirmPasswordMatch()) {
            pwMatchValidation.value = 1
            validated = false
        }
        return validated
    }
    
    private func parseAuthErrorCode(code: AuthErrorCode?, _ isLogin: Bool) -> String {
        let error: String
        switch code {
        case .invalidEmail?:
            error = StringConsts.invalidEmail
        case .emailAlreadyInUse?:
            error = StringConsts.emailInUseError
        case .wrongPassword?:
            error = StringConsts.invalidPassword
        case .invalidCredential?:
            error = StringConsts.invalidCredentials
        default:
            error = isLogin ? StringConsts.genericLoginError : StringConsts.genericSignUpError
        }
        return error
    }
    
    func createUser(email: String, password: String) {
        authService.createUser(
            email: email,
            password: password,
            callback: { authResult, error in
                if let e = error {
                    let code = AuthErrorCode(rawValue: e._code)
                    let authError = AuthError(
                        title: StringConsts.signUpError,
                        description: self.parseAuthErrorCode(code: code, false)
                    )
                    self.authError.value = authError
                } else {
                    self.authSuccess.value = authResult
                }
        })
    }
    
    func login(email: String, password: String) {
        authService.login(
            email: email,
            password: password,
            callback: { authResult, error in
                if let e = error {
                    let code = AuthErrorCode(rawValue: e._code)
                    let authError = AuthError(
                        title: StringConsts.loginError,
                        description: self.parseAuthErrorCode(code: code, true)
                    )
                    
                    self.authError.value = authError
                } else {
                    self.authSuccess.value = authResult
                }
        })
    }
    
    func signIn(credentials: AuthCredential, provider: AuthProvider) {
        authService.signIn(with: credentials, provider: provider, callback: { (authResult, error) in
            if let _ = error {
                self.authError.value = self.googleSignInError() 
            } else {
                self.authSuccess.value = authResult
            }
        })
    }
    
    func googleSignInError() -> AuthError {
        return AuthError(title: StringConsts.loginTitle, description: StringConsts.googleSignInError)
    }
    
    func facebookSignInError() -> AuthError {
        return AuthError(title: StringConsts.loginTitle, description: StringConsts.facebookSignInError)
    }
}

// Wrapper for Auth Errors from Firebase
struct AuthError {
    
    //Title of the error, whether it is a Login or Sign Up error.
    var title: String
    var description: String
}
