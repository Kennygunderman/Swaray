//
//  LoginManager.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/23/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import GoogleSignIn
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

// Manager for handling all routes of Logging in to the application
// see `AuthProvider` for all possible Login routes.
class SignInManager: NSObject, GIDSignInDelegate {
    
    var delegate: SignInManagerDelegate?
  
    let authService: AuthServiceInterface
    
    init(authService: AuthServiceInterface) {
        self.authService = authService
    }
    
    // Implement Google Delegate Sign In Logic.
    // Once Google Sign In is complete, auth with the credential token provided from Google.
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let e = error {
            self.delegate?.signInError(error: e, from: .google)
        } else {
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(
                withIDToken: authentication.idToken,
                accessToken: authentication.accessToken
            )
            
            self.auth(with: credential, from: .google)
        }
    }
    
    // Call's the Google Sign In delegate method
    func googleSignIn(presentingViewController: UIViewController) {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = presentingViewController
        GIDSignIn.sharedInstance().signIn()
    }
    
    // Handles loggin in with facebook.
    // Once Facebook Sign In is complete, auth with the credential token provided from Facebook.
    func facebookSignIn(presentingController: UIViewController) {
        // Create instance of FB LoginManager
        let loginManager = LoginManager()
        
        loginManager.logIn(permissions: ["email"], from: presentingController) { (result, error) -> Void in
            if let e = error {
                self.delegate?.signInError(error: e, from: .facebook)
            } else {
                if let result = result {
                    if (result.grantedPermissions.contains("email"))  {
                        let cred = FacebookAuthProvider
                            .credential(withAccessToken: result.token?.tokenString ?? "")
                        self.auth(with: cred, from: .facebook)
                    }
                }
            }
        }
    }
    
    func createUser(email: String, password: String) {
        self.delegate?.authing()
        authService.createUser(email: email, password: password) { (result, error) in
            self.handleAuthResult(result: result, error: error, provider: .creation)
        }
    }
    
    func auth(with email: String, password: String) {
        self.delegate?.authing()
        authService.auth(with: email, password: password) { (result, error) in
            self.handleAuthResult(result: result, error: error, provider: .login)
        }
    }
    
    private func auth(with credential: AuthCredential, from: AuthProvider) {
        self.delegate?.authing()
        authService.auth(with: credential, provider: from) { (result, error) in
            self.handleAuthResult(result: result, error: error, provider: from)
        }
    }
    
    func handleAuthResult(result: AuthResult?, error: Error?, provider: AuthProvider) {
        if let e = error {
            self.delegate?.authError(error: AuthErrorCode(rawValue: e._code), from: provider)
        } else {
            self.delegate?.authed(result: result)
        }
    }
}

protocol SignInManagerDelegate {
    
    // Called when there is an Error singing in.
    // This is typically called when there is an issue signing in with a third party such as google, or facebook.
    // this is NOT the same as `authError`
    func signInError(error: Error, from: AuthProvider)
    
    // Called when Sign In is Complete, and authing is started
    func authing()
    
    // Called when an error occurs when authing against this authorization client
    // Currently, this client is Firebase.
    func authError(error: AuthErrorCode?, from: AuthProvider)
    
    // Auth success
    func authed(result: AuthResult?)
}
