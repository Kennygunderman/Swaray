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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillHideNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    var isChanged = false
    
    @objc func keyboardWillChange(notification: NSNotification) {
        
        let btn =  self.baseView.signUpBtn
        let btnHeight = self.view.frame.size.height - (btn.frame.size.height + btn.frame.origin.y)
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            if notification.name == UIResponder.keyboardWillShowNotification ||
                notification.name == UIResponder.keyboardWillChangeFrameNotification {
                
                if (!isChanged) {
                    isChanged = true
                   // view.frame.origin.y = -20
                }
                
            } else {
              //  view.frame.origin.y = 0
            }
            
            
//            let keyboardHeight = keyboardFrame.cgRectValue.height
//            if (keyboardHeight > btnHeight) {
//                UIView.animate(withDuration: 0.5,
//                               delay: 0.1,
//                               usingSpringWithDamping: 1,
//                               initialSpringVelocity: 1,
//                               options: .curveEaseIn,
//                               animations: {
//                                 self.view.frame = CGRect(x: 0, y: btnHeight - keyboardHeight, width: self.view.frame.width, height: self.view.frame.height)
//                }, completion: nil)
//            } else {
//               // keyboardWillHide(notification: notification)
//            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.5,
                       delay: 0.1,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn,
                       animations: {
                        
                         self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                        
        }, completion: nil)
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
                self.baseView.signUpBtn.animate()
                self.baseView.signUpBtn.isEnabled = true
            }
        }
        
        _ = viewModel.authSuccess.observeNext { result in
            if let _ = result {
                self.baseView.signUpBtn.setTitle(StringConsts.signUpSuccess, for: .normal)
                self.baseView.signUpBtn.animate()
                
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
        baseView.returnToLoginBtn
            .addTarget(self, action: #selector(handleReturnToLogin), for: .touchUpInside)
        
        baseView.signUpBtn
            .addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    }
    
    @objc private func handleSignUp() {
        if viewModel.validate() {
            baseView.signUpBtn.animate()
            baseView.signUpBtn.isEnabled = false
            viewModel.createUser(
                email: viewModel.email.value ?? "",
                password: viewModel.password.value ?? ""
            )
        }
    }
    
    @objc private func handleReturnToLogin() {
        baseView.handleExitAnimation {
            self.navigationController?.popViewController(animated: false)
        }
    }
}
