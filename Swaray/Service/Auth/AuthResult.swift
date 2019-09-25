//
//  AuthResult.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/24/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation

// Custom Auth Result.
// This is used to grab the subset of data needed from `AuthDataResult`.
struct AuthResult {
    var provider: AuthProvider
    var email: String
}
