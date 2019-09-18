//
//  SignUpViewModelTest.swift
//  SwarayTests
//
//  Created by Kenny Gunderman on 9/18/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation

import XCTest
@testable import Swaray

class LoginViewModelTests: XCTestCase {
    let viewModel = LoginViewModel()
    
    func testValidateEmail() {
        viewModel.email.value = "test@test"
        XCTAssertFalse(viewModel.validateEmail())
        
        viewModel.email.value = ""
        XCTAssertFalse(viewModel.validateEmail())
        
        viewModel.email.value = "test"
        XCTAssertFalse(viewModel.validateEmail())
        
        viewModel.email.value = "~!#$$"
        XCTAssertFalse(viewModel.validateEmail())
        
        viewModel.email.value = "~!#$$@123.com"
        XCTAssertFalse(viewModel.validateEmail())
        
        viewModel.email.value = "kenny~gunderman!@gmail.com"
        XCTAssertFalse(viewModel.validateEmail())
        
        viewModel.email.value = "test@test."
        XCTAssertFalse(viewModel.validateEmail())
        
        viewModel.email.value = "~!#$@!!!.com"
        XCTAssertFalse(viewModel.validateEmail())
        
        viewModel.email.value = "test@test.com"
        XCTAssertTrue(viewModel.validateEmail())
    }
    
    func testValidatePassword() {
        viewModel.password.value = "passw"
        XCTAssertFalse(viewModel.validatePassword())
        
        viewModel.password.value = ""
        XCTAssertFalse(viewModel.validatePassword())
        
        viewModel.password.value = "password"
        XCTAssertTrue(viewModel.validatePassword())
    }
    
    func testValidatedPasswordMatch() {
        viewModel.password.value = "passw"
        viewModel.confirmPassword.value = "pass"
        XCTAssertFalse(viewModel.confirmPasswordMatch())
        
        viewModel.password.value = "password"
        viewModel.confirmPassword.value = ""
        XCTAssertFalse(viewModel.confirmPasswordMatch())
        
        viewModel.password.value = ""
        viewModel.confirmPassword.value = ""
        XCTAssertFalse(viewModel.confirmPasswordMatch())
        
        viewModel.password.value = "pass"
        viewModel.confirmPassword.value = "pass"
        XCTAssertFalse(viewModel.confirmPasswordMatch())
        
        viewModel.password.value = ""
        viewModel.confirmPassword.value = "password"
        XCTAssertFalse(viewModel.confirmPasswordMatch())
        
        viewModel.password.value = "password"
        viewModel.confirmPassword.value = "password"
        XCTAssertTrue(viewModel.confirmPasswordMatch())
    }
    
    func testValidate() {
        viewModel.email.value = "invalid-format-email"
        viewModel.password.value = "2shrt"
        viewModel.confirmPassword.value = "2shrt"
        
        var result = viewModel.validate()
        XCTAssertTrue(viewModel.emailValidation.value == 1)
        XCTAssertTrue(viewModel.passwordValidation.value == 1)
        XCTAssertTrue(viewModel.pwMatchValidation.value == 0)
        XCTAssertFalse(result)
        
        viewModel.email.value = "validEmail@email.com"
        viewModel.password.value = "password"
        viewModel.confirmPassword.value = "pass0wrd"
        
        result = viewModel.validate()
        XCTAssertTrue(viewModel.emailValidation.value == 0)
        XCTAssertTrue(viewModel.passwordValidation.value == 0)
        XCTAssertTrue(viewModel.pwMatchValidation.value == 1)
        XCTAssertFalse(result)
        
        viewModel.email.value = "validEmail@email.com"
        viewModel.password.value = "password"
        viewModel.confirmPassword.value = "password"
        
        result = viewModel.validate()
        XCTAssertTrue(viewModel.emailValidation.value == 0)
        XCTAssertTrue(viewModel.passwordValidation.value == 0)
        XCTAssertTrue(viewModel.pwMatchValidation.value == 0)
        XCTAssertTrue(result)
    }
}
