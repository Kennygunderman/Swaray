//
//  AuthService.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/18/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import Firebase

class AuthService: NSObject, AuthServiceInterface {
    func createUser(email: String, password: String, callback: @escaping (AuthResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
            callback(self.parseResult(result, provider: .creation), error)
        })
    }
    
    func auth(with email: String, password: String, callback: @escaping (AuthResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            callback(self.parseResult(result, provider: .login), error)
        }
    }

    // login in with AuthCredential.
    // Param `AuthProvider` is needed to determine what the User is signing in with. (app email & password, google, or facebook)
    func auth(with credential: AuthCredential, provider: AuthProvider, callback: @escaping (AuthResult?, Error?) -> Void) {
        Auth.auth().signIn(with: credential) { result, error in
            callback(self.parseResult(result, provider: provider), error)
        }
    }
        
    // Parse's the Firebase Auth result into a AuthResult we can use.
    private func parseResult(_ firebaseAuthResult: AuthDataResult?, provider: AuthProvider) -> AuthResult? {
        var authResult: AuthResult?
        if let user = firebaseAuthResult?.user {
            authResult = AuthResult(provider: provider, email: user.email ?? "")
        }
        return authResult
    }
}
