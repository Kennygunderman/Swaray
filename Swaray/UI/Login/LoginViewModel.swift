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
    
    let authError = Observable<String?>(nil)
    let authSuccess = Observable<AuthDataResult?>(nil)
    
    init() {
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
    
    func validate() -> Bool {
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
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                self.authError.value = e.localizedDescription
            } else {
                self.authSuccess.value = authResult
            }
        }
    }
}
