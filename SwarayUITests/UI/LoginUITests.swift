//
//  SwarayUITests.swift
//  SwarayUITests
//
//  Created by Kenny Gunderman on 9/13/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import XCTest

class LoginUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    // Test's transition from Login to Sign Up
    func testTransition() {
        let app = XCUIApplication()
        let actionButton = app.buttons["loginActionBtnId"]
        let confirmPw = app.secureTextFields["confirmPwTxtId"]
        let loginButton = app.buttons["loginBtnId"]
        XCTAssertEqual(false, confirmPw.exists)
        XCTAssertEqual("Login", loginButton.label)

        actionButton.tap() //navigate to Sign Up
        sleep(1) //Wait for animation to stop
        
        //confirm password field is shown
        XCTAssertEqual(true, confirmPw.exists)
        
        //check if button text has updated
        XCTAssertEqual("Sign Up", loginButton.label)
        
        actionButton.tap() //go back to login
        sleep(1) //Wait for animation to stop
        
        XCTAssertEqual(false, confirmPw.exists)
        XCTAssertEqual("Login", loginButton.label)
    }
    
    //Test's validation labels are displaying properly
    func testValidation() {
        let app = XCUIApplication()
        app.buttons["loginActionBtnId"].tap()
        sleep(1)
        
        let emailValidation = app.staticTexts["emailValidationLabelId"]
        let passwordValidation = app.staticTexts["passwordValidationLabelId"]
        
        XCTAssertEqual(false, emailValidation.exists)
        XCTAssertEqual(false, passwordValidation.exists)
        
        let emailTxt = app.textFields["emailTxtId"]
        emailTxt.tap()
        emailTxt.typeText("invalidEmail@Email")
        emailTxt.typeText("\n")
        
        let passwordTxt = app.secureTextFields["passwordTxtId"]
        passwordTxt.tap()
        passwordTxt.typeText("12345")
        passwordTxt.typeText("\n")
        
        let signUpBtn = app.buttons["loginBtnId"]
        signUpBtn.tap()
        
        XCTAssertEqual(true, emailValidation.exists)
        XCTAssertEqual(true, passwordValidation.exists)
        
        emailTxt.tap()
        emailTxt.typeText(".com")
        emailTxt.typeText("\n")
        
        passwordTxt.tap()
        passwordTxt.typeText("123456")
        passwordTxt.typeText("\n")
        
        XCTAssertEqual(false, emailValidation.exists)
        XCTAssertEqual(false, passwordValidation.exists)
    }
    
    func testSignUpSuccess() {
        let app = XCUIApplication()
        app.buttons["loginActionBtnId"].tap()
        
        let emailTxt = app.textFields["emailTxtId"]
        emailTxt.tap()
        emailTxt.typeText("valid@Email.com")
        emailTxt.typeText("\n")
        
        let passwordTxt = app.secureTextFields["passwordTxtId"]
        passwordTxt.tap()
        passwordTxt.typeText("123456")
        passwordTxt.typeText("\n")
        
        let confirmPw = app.secureTextFields["confirmPwTxtId"]
        confirmPw.tap()
        confirmPw.typeText("123456")
        confirmPw.typeText("\n")
        
        //check that values are on the screen
        XCTAssertEqual(true, emailTxt.exists)
        XCTAssertEqual(true, passwordTxt.exists)
        XCTAssertEqual(true, confirmPw.exists)

        let signUpBtn = app.buttons["loginBtnId"]
        signUpBtn.tap()
        
        // Check login button
        XCTAssertEqual("Success!", signUpBtn.label)
        sleep(2)
        
        //check values are gone
        XCTAssertEqual(false, emailTxt.exists)
        XCTAssertEqual(false, passwordTxt.exists)
        XCTAssertEqual(false, confirmPw.exists)
    }
    
    func testLoginSucces() {
        let app = XCUIApplication()        
        let emailTxt = app.textFields["emailTxtId"]
        emailTxt.tap()
        emailTxt.typeText("valid@Email.com")
        emailTxt.typeText("\n")
        
        let passwordTxt = app.secureTextFields["passwordTxtId"]
        passwordTxt.tap()
        passwordTxt.typeText("123456")
        passwordTxt.typeText("\n")
        
        //check that values are on the screen
        XCTAssertEqual(true, emailTxt.exists)
        XCTAssertEqual(true, passwordTxt.exists)
        
        let loginBtn = app.buttons["loginBtnId"]
        loginBtn.tap()
        
        // Check login button
        XCTAssertEqual("Success!", loginBtn.label)
        sleep(2)
        
        //check values are gone
        XCTAssertEqual(false, emailTxt.exists)
        XCTAssertEqual(false, passwordTxt.exists)
    }
}
