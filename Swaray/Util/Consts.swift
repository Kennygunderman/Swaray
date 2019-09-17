//
//  Consts.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/13/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//
// This File is responsible for all constant values
// used throught the application.


import Foundation
import UIKit

struct StringConsts {
    static let appName: String = "Swaray"
    
    // Static vals for Login
    static let loginTitle: String = "Login"
    static let noAccountLabel: String = "Don't have an account? "
    static let createAccBtnTxt: String = "Create one here."
    
    // Static vals for Sign Up
    static let signUpTitle = "Sign Up"
    static let hasAccountLabel: String = "Already have an account? "
    static let goToLoginBtnTxt: String = "Log in here."
    static let emailTxtPlaceholder: String = "Email"
    static let passwordTxtPlaceholder: String = "Password"
    static let pwConfirmTxtPlaceholder: String = "Confirm password"
    static let emailValidation: String = "Please enter a valid email."
    static let passwordValidation: String = "Password must be at least 6 characters."
    static let passwordMatchValidation: String = "Passwords do not match."
    static let signUpBtnText = "SIGN UP"
    static let signUpError = "Error creating account"
    static let signUpSuccess = "SUCCESS!"
}

struct DimenConsts {
    //height of the triangle `cut` used in Login, Sign Up & Home
    static let triangleCutHeight = 100
    static let headerFontSize: CGFloat = 36
    static let subHeaderFontSize: CGFloat = 24
    static let smallFontSize: CGFloat = 12
    static let regularFontSize: CGFloat = 14
    static let largeFontSize: CGFloat = 18
}
