//
//  File.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/19/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

// Mock AuthService
// This class will only get compiled and used under the `Mock` Build configuration.
//
// This type of set up inspired by: https://medium.com/@londeix/xcode-file-variants-without-targets-9724cbabe821

import Foundation
import Firebase

class AuthService: AuthServiceInterface {
    func createUser(email: String, password: String, callback: @escaping (AuthResult?, Error?) -> Void) {
        callback(AuthResult(provider: .creation, email: "mock@email.com"), nil)
    }
    
    func auth(with email: String, password: String, callback: @escaping (AuthResult?, Error?) -> Void) {
        callback(AuthResult(provider: .login, email: "mock@email.com"), nil)
    }
    
    func auth(with credential: AuthCredential, provider: AuthProvider, callback: @escaping (AuthResult?, Error?) -> Void) {
        callback(AuthResult(provider: .login, email: "mock@email.com"), nil)
    }
}
