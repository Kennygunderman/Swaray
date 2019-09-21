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

class AuthService: AuthServiceInterface {
    func createUser(email: String, password: String, callback: @escaping (AuthResult?, Error?) -> Void) {
        callback(AuthResult(email: "mock@email.com"), nil)
    }
    
    func login(email: String, password: String, callback: @escaping (AuthResult?, Error?) -> Void) {
        callback(AuthResult(email: "mock@email.com"), nil)
    }
}
