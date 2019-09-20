//
//  AuthServiceInterface.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/19/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation

// Custom Auth Result.
// This is used to grab the subset of data needed from `AuthDataResult`.
struct AuthResult {
    var email: String
}

protocol AuthServiceInterface {
    func createUser(email: String, password: String, callback: @escaping  (AuthResult?, Error?) -> Void)
}
