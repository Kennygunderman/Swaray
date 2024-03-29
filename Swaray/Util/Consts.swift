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

public struct StringConsts {
    static let appName: String = "Swaray"
    
    // Static vals for Login
    static let loginTitle: String = "Login"
    static let noAccountLabel: String = "Don't have an account? "
    static let createAccBtnTxt: String = "Create one here."
    static let loginBtnText: String = "Login"
    
    // Static vals for Sign Up
    static let signUpTitle: String = "Sign Up"
    static let hasAccountLabel: String = "Already have an account? "
    static let goToLoginBtnTxt: String = "Log in here."
    static let emailTxtPlaceholder: String = "Email"
    static let passwordTxtPlaceholder: String = "Password"
    static let pwConfirmTxtPlaceholder: String = "Confirm password"
    static let emailValidation: String = "Please enter a valid email."
    static let passwordValidation: String = "Password must be at least 6 characters."
    static let passwordMatchValidation: String = "Passwords do not match."
    static let signUpBtnText: String = "Sign Up"
    static let signUpSuccess: String = "Success!"
    static let signUpOrLabel: String = "Or"
    
    // Social Logins
    static let googleSignUpBtnText: String = "Sign In with Google"
    static let facebookSignUpBtnText: String = "Sign In with Facebook"
    
    // Login/Sign Up errors
    static let signUpErrorTitle: String = "Error Creating Account"
    static let loginErrorTitle: String = "Error Logging In"
    static let emailInUseError: String = "The email you have provided is already in use."
    static let invalidEmail: String = "The email you have provided is invalid."
    static let invalidPassword: String = "The password you have provided is invalid."
    static let invalidCredentials: String = "The email or password you have provided is invalid."
    static let genericLoginError: String = "Unable to login with the email and password you have provided."
    static let genericSignUpError: String = "Unable to sign up with the email and password you have provided. Please try again."
    static let googleSignInError: String = "Unable to sign in with Google at this time."
    static let facebookSignInError: String = "Unable to sign in with Facebook at this time."
    
    //static vals for Home
    static let hostingOrJoiningLabel: String = "Will you be hosting an event or joining one?"
    static let hostingLabel: String = "Hosting"
    
    //vals for EventCreation
    
    //Name
    static let eventCreationNameHint = "i.e Ciara's 30th Birthday Party"
    static let eventCreationDateHint = "--/--/2020"
    static let eventNameLabel = "What's this Event for?"
    
    //Date
    static let eventDateLabel = "When is the Event happening?"
    static let eventNameValidationLavel = "Please add a name"
    static let eventDateValidationLavel = "Please add a valid date"
    
    //Error vals
    static let firestoreSaveEventErrorTitle = "Error Saving Event"
    static let eventCreationErrorTitle = "Error Creating Event"
    static let genericError = "Please contact support if this error persists."
    static let invalidUser = "Unable to create an Event with your account. Please try logging out and back in."
    static let invalidDate = "The date you have provided is invalid. Please make sure the format follows mm/dd/yyyy."
}

struct DimenConsts {
    //height of the triangle `cut` used in Login, Sign Up & Home
    static let triangleCutHeight: CGFloat = UIScreen.main.nativeBounds.height <= 1136 ? 80 : 100
    static let loginBgBottomConstraint: CGFloat = UIScreen.main.nativeBounds.height <= 1136 ? 120 : 144
    static let headerFontSize: CGFloat = 36
    static let subHeaderFontSize: CGFloat = 24
    static let smallFontSize: CGFloat = 12
    static let regularFontSize: CGFloat = 14
    static let largeFontSize: CGFloat = 18
}
