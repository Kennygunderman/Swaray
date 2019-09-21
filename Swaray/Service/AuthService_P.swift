//
//  AuthService.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/18/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import Firebase

class AuthService: AuthServiceInterface {
    func createUser(email: String, password: String, callback: @escaping (AuthResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
            var authResult: AuthResult?
            if let user = result?.user {
                authResult = AuthResult(email: user.email ?? "")
            }
            callback(authResult, error)
        })
    }
    
    func login(email: String, password: String, callback: @escaping (AuthResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            var authResult: AuthResult?
            if let user = result?.user {
                authResult = AuthResult(email: user.email ?? "")
            }
            callback(authResult, error)
        }
    }
}
