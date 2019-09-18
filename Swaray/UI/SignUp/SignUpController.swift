//
//  SignUpController.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/14/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit
class SignUpController: BaseController<SignUpView>, UITextFieldDelegate {
    private var state: LoginState = .login
    private var currentFocus: UITextField? = nil
    private let viewModel = SignUpViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        bindViews()
        subscribeUi()
    }
    
    private func bindViews() {
        // Bind TextFields
        viewModel.email.bidirectionalBind(to: baseView.emailTxt.reactive.text)
        viewModel.password.bidirectionalBind(to: baseView.passwordTxt.reactive.text)
        viewModel.confirmPassword.bidirectionalBind(to: baseView.passwordConfirmTxt.reactive.text)
    
        // Bind Validation Labels
        viewModel.emailValidation.bind(to: baseView.emailValidationLabel.reactive.alpha)
        viewModel.passwordValidation.bind(to: baseView.passwordValidationLabel.reactive.alpha)
        viewModel.pwMatchValidation.bind(to: baseView.pwMatchValidationLabel.reactive.alpha)
    }
    
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
    
    private func showErrorDialog(error: String) {
        let alert = UIAlertController(
            title: StringConsts.signUpError,
            message: error,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func setupActions() {
        baseView.actionBtn.addTarget(self, action: #selector(handleAction), for: .touchUpInside)
        
        baseView.loginBtn
            .addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    @objc private func handleLogin() {
        if (state == .login) {
            login()
        } else {
            signUp()
        }
    }
    
    func login() {
        
    }
    
    func signUp() {
        if viewModel.validate() {
            baseView.loginBtn.animate()
            baseView.loginBtn.isEnabled = false
            viewModel.createUser(
                email: viewModel.email.value ?? "",
                password: viewModel.password.value ?? ""
            )
        }
    }
    
    @objc private func handleAction() {
        state = state == .login ? .signUp : .login
        baseView.animateStateChange(state: state)
        currentFocus?.resignFirstResponder()
    }
}
