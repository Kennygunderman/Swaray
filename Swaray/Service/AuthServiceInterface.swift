//
//  AuthServiceInterface.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/19/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import Firebase

// Custom Auth Result.
// This is used to grab the subset of data needed from `AuthDataResult`.
struct AuthResult {
    var provider: AuthProvider
    var email: String
}

enum AuthProvider {
    case app
    case google
    case facebook
}

protocol AuthServiceInterface {
    func createUser(email: String, password: String, callback: @escaping  (AuthResult?, Error?) -> Void)
    func login(email: String, password: String, callback: @escaping (AuthResult?, Error?) -> Void)
    func signIn(with: AuthCredential, provider: AuthProvider, callback: @escaping (AuthResult?, Error?) -> Void)
}
