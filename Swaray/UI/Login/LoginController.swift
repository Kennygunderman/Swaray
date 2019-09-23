//
//  SignUpController.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/14/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import Firebase
import FBSDKLoginKit // remove one
import FBSDKCoreKit  // of these two

class LoginController: BaseController<LoginView, LoginViewModel> {
    private var state: LoginState = .login // State of controller
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        subscribeUi()
        GIDSignIn.sharedInstance().delegate = self //set Google Sign In delegate
    }
    
    override func getViewModel() -> LoginViewModel? {
        return viewModel
    }
    
    // Subscribe UI to changes in observers from ViewModel
    private func subscribeUi() {
        _ = viewModel.authError.observeNext { error in
            if let e = error {
                self.showErrorDialog(error: e)
                self.baseView.loginBtn.animate()
                self.enableLoginButtons()
            }
        }
        
        _ = viewModel.authSuccess.observeNext { result in
            if let _ = result {
                self.baseView.loginBtn.animate()
                self.baseView.loginBtn.setTitle(title: StringConsts.signUpSuccess)
                
                // Wait 1 second before navigating. This is done because we want to give
                // the user enough time to read the success message of their account creation.
                _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.navigateToHome), userInfo: nil, repeats: false)
            }
        }
    }
    
    @objc private func navigateToHome() {
        self.baseView.handleExitAnimation {
            self.navigationController?.pushViewController(HomeController(), animated: false)
        }
    }
    
    private func showErrorDialog(error: AuthError) {
        let alert = UIAlertController(
            title: error.title,
            message: error.description,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func setupActions() {
        baseView.actionBtn.addTarget(self, action: #selector(handleAction), for: .touchUpInside)
        baseView.loginBtn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        baseView.googleBtn.addTarget(self, action: #selector(handleGoogleSignIn), for: .touchUpInside)
        baseView.facebookBtn.addTarget(self, action: #selector(handleFacebookSignIn), for: .touchUpInside)
    }
    
    @objc private func handleGoogleSignIn() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    @objc private func handleFacebookSignIn() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
            self.disableLoginButtons()
            self.baseView.loginBtn.animate()
            
            if let _ = error {
                self.viewModel.authError.value = self.viewModel.facebookSignInError()
            } else {
                if let result = result {
                    if (result.grantedPermissions.contains("email"))  {
                        let cred = FacebookAuthProvider
                                .credential(withAccessToken: result.token?.tokenString ?? "")
                        self.viewModel.signIn(credentials: cred, provider: .facebook)
                    }
                }
            }
        }
    }
    
    @objc private func handleLogin() {
        if (state == .login) {
            login()
        } else {
            signUp()
        }
    }
    
    func login() {
        if (viewModel.validateLogin()) {
            disableLoginButtons()
            baseView.loginBtn.animate()
            viewModel.login(
                email: viewModel.email.value ?? "",
                password: viewModel.password.value ?? ""
            )
        }
    }
    
    private func enableLoginButtons() {
        baseView.loginBtn.isEnabled = true
        baseView.googleBtn.isEnabled = true
        baseView.facebookBtn.isEnabled = true
    }
    
    private func disableLoginButtons() {
        baseView.loginBtn.isEnabled = false
        baseView.googleBtn.isEnabled = false
        baseView.facebookBtn.isEnabled = false
    }
    
    func signUp() {
        if viewModel.validateSignUp() {
            disableLoginButtons()
            baseView.loginBtn.animate()
            viewModel.createUser(
                email: viewModel.email.value ?? "",
                password: viewModel.password.value ?? ""
            )
        }
    }
    
    @objc private func handleAction() {
        state = state == .login ? .signUp : .login
        baseView.animateStateChange(state: state)
        baseView.currentTextFocus?.resignFirstResponder()
    }
}

// Delegate functions for Google Log In
extension LoginController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let e = error {
            if e._code != -1 {
                viewModel.authError.value = viewModel.googleSignInError()
            }
        } else {
            guard let authentication = user.authentication else { return }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: authentication.idToken,
                accessToken: authentication.accessToken
            )
            
            disableLoginButtons()
            baseView.loginBtn.animate()
            viewModel.signIn(credentials: credential, provider: .google)
        }
    }
}
