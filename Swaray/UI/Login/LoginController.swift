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

class LoginController: BaseController<LoginView, LoginViewModel> {
    private var state: LoginState = .login // State of controller
    let viewModel = LoginViewModel()
    
    private var currentLoginButton: LoadingButton? {
        didSet {
            currentLoginButton?.animate()
        }
    }
    
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
                self.currentLoginButton?.animate()
                self.currentLoginButton = nil
                self.enableLoginButtons()
            }
        }
        
        _ = viewModel.authSuccess.observeNext { result in
            if let _ = result {
                self.currentLoginButton?.animate()
                self.currentLoginButton?.setTitle(title: StringConsts.signUpSuccess)
                
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
    }
    
    @objc private func handleGoogleSignIn() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
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
            self.currentLoginButton = baseView.loginBtn
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
            self.currentLoginButton = baseView.loginBtn
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
            return
        }
        
        guard let authentication = user.authentication else { return }
        
        let credential = GoogleAuthProvider.credential(
            withIDToken: authentication.idToken,
            accessToken: authentication.accessToken
        )
        
        disableLoginButtons()
        self.currentLoginButton = baseView.googleBtn
        viewModel.signIn(credentials: credential, provider: .google)
    }
}
