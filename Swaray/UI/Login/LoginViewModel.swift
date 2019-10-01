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
    let authingTrigger = Observable<Bool>(false)
    let authSuccess = Observable<AuthResult?>(nil)
    
    let signInManager: SignInManager
    
    init(signInManager: SignInManager = getSignInManager()) {
        self.signInManager = signInManager
        signInManager.delegate = self
        
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
    
    func createUser(email: String, password: String) {
        signInManager.createUser(email: email, password: password)
    }
    
    func login(email: String, password: String) {
        signInManager.auth(with: email, password: password)
    }
    
    private func googleSignInError() -> AuthError {
        return AuthError(title: StringConsts.loginErrorTitle, description: StringConsts.googleSignInError)
    }

    private func facebookSignInError() -> AuthError {
        return AuthError(title: StringConsts.loginErrorTitle, description: StringConsts.facebookSignInError)
    }
}

// SignInManager Delegate functions
extension LoginViewModel: SignInManagerDelegate {
    func signInError(error: Error, from: AuthProvider) {
        if error._code == -1 {
            return
        }
        
        switch from {
        case .google:
            self.authError.value = googleSignInError()
        case .facebook:
            self.authError.value = facebookSignInError()
        default:
            self.authError.value = AuthError(title: StringConsts.loginErrorTitle, description: StringConsts.genericLoginError)
        }
    }
    
    // While authing is in progress, we want to notify the UI to make any changes,
    // such as displaying a spinner.
    func authing() {
        authingTrigger.value = true
    }
    
    func authed(result: AuthResult?) {
        self.authSuccess.value = result
    }
    
    // This implementation with return a generic error for Google & Facebook,
    // but provide a more descriptive error if the AuthProvider is from creation or login.
    func authError(error: AuthErrorCode?, from: AuthProvider) {
        switch from {
        case .google:
            self.authError.value = googleSignInError()
            break
        case .facebook:
            self.authError.value = facebookSignInError()
            break
        case .login, .creation:
            var errorDesc = ""
            if let code = error {
                errorDesc = parseAuthErrorCode(code: code) ?? (from == .login ? StringConsts.genericLoginError : StringConsts.genericSignUpError)
            }
            let title = from == .login ? StringConsts.loginErrorTitle : StringConsts.signUpErrorTitle
            self.authError.value = AuthError(title: title, description: errorDesc)
            break
        }
    }
    
    // Parse the AuthErrorCode to return a more informative error
    private func parseAuthErrorCode(code: AuthErrorCode) -> String? {
        let error: String
        switch code {
        case .invalidCredential:
            error = StringConsts.invalidCredentials
        case .invalidEmail:
            error = StringConsts.invalidEmail
        case .emailAlreadyInUse:
            error = StringConsts.emailInUseError
        case .wrongPassword:
            error = StringConsts.invalidPassword
        default:
            return nil
        }
        return error
    }
}
