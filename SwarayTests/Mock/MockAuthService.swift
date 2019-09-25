//
//  MockAuthService.swift
//  SwarayTests
//
//  Created by Kenny Gunderman on 9/19/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
@testable import Swaray
import Firebase


// Mock that doesn't do anything.
// This mock is used for testing Functions in which the
// parent object has dependency on an AuthServiceInterface
// but the actual function does not.
class MockAuthService: AuthServiceInterface {
    func createUser(email: String, password: String, callback: @escaping (AuthResult?, Error?) -> Void) {
        // Do nothing
    }
    
    func auth(with email: String, password: String, callback: @escaping (AuthResult?, Error?) -> Void) {
        // Do nothing
    }
    
    func auth(with credential: AuthCredential, provider: AuthProvider, callback: @escaping (AuthResult?, Error?) -> Void) {
        // Do nothing
    }
}

class MockAuthServiceError: AuthServiceInterface {
    let errorCode: AuthErrorCode
    init(errorCode: AuthErrorCode) {
        self.errorCode = errorCode
    }
    
    let userInfo: [String : Any] =
        [NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: "Test Error", comment: "")]
    
    func createUser(email: String, password: String, callback: @escaping (AuthResult?, Error?) -> Void) {
        let error = NSError(domain: "test", code: errorCode.rawValue, userInfo: userInfo)
        callback(nil, error)
    }
    
    func auth(with email: String, password: String, callback: @escaping (AuthResult?, Error?) -> Void) {
        let error = NSError(domain: "test", code: errorCode.rawValue, userInfo: userInfo)
        callback(nil, error)
    }
    
    func auth(with credential: AuthCredential, provider: AuthProvider, callback: @escaping (AuthResult?, Error?) -> Void) {
        let error = NSError(domain: "test", code: errorCode.rawValue, userInfo: userInfo)
        callback(nil, error)
    }
}

class MockAuthServiceSuccess: AuthServiceInterface {
    
    let successResult: AuthResult
    init(result: AuthResult) {
        self.successResult = result
    }
    
    func createUser(email: String, password: String, callback: @escaping (AuthResult?, Error?) -> Void) {
        callback(successResult, nil)
    }
    
    func auth(with email: String, password: String, callback: @escaping (AuthResult?, Error?) -> Void) {
        callback(successResult, nil)
    }
    
    func auth(with credential: AuthCredential, provider: AuthProvider, callback: @escaping (AuthResult?, Error?) -> Void) {
        callback(successResult, nil)
    }
}
