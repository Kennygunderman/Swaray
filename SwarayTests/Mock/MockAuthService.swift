//
//  MockAuthService.swift
//  SwarayTests
//
//  Created by Kenny Gunderman on 9/19/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
@testable import Swaray

class MockAuthServiceError: AuthServiceInterface {
    let userInfo: [String : Any] =
        [NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: "Test Error", comment: "")]
    
    func createUser(email: String, password: String, callback: @escaping (AuthResult?, Error?) -> Void) {
        let error = NSError(domain: "test", code: 1, userInfo: userInfo)
        callback(nil, error)
    }
}

class MockAuthServiceSuccess: AuthServiceInterface {
    let userInfo: [String : Any] =
        [NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: "Test Error", comment: "")]
    
    func createUser(email: String, password: String, callback: @escaping (AuthResult?, Error?) -> Void) {
        callback(AuthResult(email: "success@email.com"), nil)
    }
}
