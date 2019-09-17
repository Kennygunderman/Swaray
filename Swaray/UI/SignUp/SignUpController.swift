//
//  SignUpController.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/14/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit
class SignUpController: BaseController<SignUpView> {
    
    let viewModel = SignUpViewModel() // move to base impl
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        bindViews() //move to base impl
        subscribeUi()
    }
    
    fileprivate func bindViews() {
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
                self.baseView.signUpBtn.animate()
            }
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
        baseView.returnToLoginBtn
            .addTarget(self, action: #selector(handleReturnToLogin), for: .touchUpInside)
        
        baseView.signUpBtn
            .addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    }
    
    @objc func handleSignUp() {
        if viewModel.validate() {
            baseView.signUpBtn.animate()
            viewModel.createUser(
                email: viewModel.email.value ?? "",
                password: viewModel.password.value ?? ""
            )
        }
    }
    
    @objc func handleReturnToLogin() {
        baseView.handleExitAnimation {
            self.navigationController?.popViewController(animated: false)
        }
    }
}
