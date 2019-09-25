//
//  AuthServiceInterface.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/19/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import Firebase

protocol AuthServiceInterface {
    func createUser(email: String, password: String, callback: @escaping  (AuthResult?, Error?) -> Void)
    func auth(with email: String, password: String, callback: @escaping (AuthResult?, Error?) -> Void)
    func auth(with credential: AuthCredential, provider: AuthProvider, callback: @escaping (AuthResult?, Error?) -> Void)
}
