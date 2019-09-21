//
//  SignUpController.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/14/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit
class LoginController: BaseController<LoginView, LoginViewModel> {
    private var state: LoginState = .login // State of controller
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        subscribeUi()
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
                self.baseView.loginBtn.isEnabled = true
            }
        }
        
        _ = viewModel.authSuccess.observeNext { result in
            if let _ = result {
                self.baseView.loginBtn.setTitle(StringConsts.signUpSuccess, for: .normal)
                self.baseView.loginBtn.animate()
                
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
            setLoginButtonLoading()
            viewModel.login(
                email: viewModel.email.value ?? "",
                password: viewModel.password.value ?? ""
            )
        }
    }
    
    // Sets the login button to a loading state
    private func setLoginButtonLoading() {
        baseView.loginBtn.animate()
        baseView.loginBtn.isEnabled = false
    }
    
    func signUp() {
        if viewModel.validate() {
            setLoginButtonLoading()
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
