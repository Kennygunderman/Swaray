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
        XCTAssertEqual("LOGIN", loginButton.label)

        actionButton.tap() //navigate to Sign Up
        sleep(1) //Wait for animation to stop
        
        //confirm password field is shown
        XCTAssertEqual(true, confirmPw.exists)
        
        //check if button text has updated
        XCTAssertEqual("SIGN UP", loginButton.label)
        
        actionButton.tap() //go back to login
        sleep(1) //Wait for animation to stop
        
        XCTAssertEqual(false, confirmPw.exists)
        XCTAssertEqual("LOGIN", loginButton.label)
    }
}
