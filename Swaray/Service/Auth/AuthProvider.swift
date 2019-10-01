//
//  AuthProvider.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/24/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation

// Method of which auth was called from
enum AuthProvider {
    case login // app Login
    case creation // app Creation
    case google
    case facebook
}
