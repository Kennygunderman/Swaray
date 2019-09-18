//
//  SignUpView.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/14/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SignUpView: BaseControllerView {
    lazy var background: UIView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let view = UIView(frame: frame)
        view.backgroundColor = .appPrimary
        return view
    }()
    
    // Container view for holding the login/sign-up & social login buttons
    let bottomHalfView: UIView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let view = UIView(frame: frame)
        view.backgroundColor = .white
        return view
    }()
    
    // This is the magic view that creates the diagonal in the layout
    let triangle: TriangleView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let color = UIColor.white.cgColor
        let triangle = TriangleView(color: color, frame: frame)
        triangle.backgroundColor = .appPrimary
        return triangle
    }()
    
    //Login but also the Sign Up label
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = StringConsts.loginTitle
        label.textColor = .white
        label.font = loadFont(font: BaseFont.regular, size: DimenConsts.headerFontSize)
        return label
    }()
    
    // Label for the call to action (i.e Don't have an account?)
    lazy var actionLabel: UILabel = {
        let label = UILabel()
        label.text = StringConsts.noAccountLabel
        label.textColor = .white
        label.font = loadFont(font: BaseFont.regular, size: DimenConsts.regularFontSize)
        return label
    }()
    
    // Button for the call to action
    lazy var actionBtn: HighlightableTextButton = {
        let button = HighlightableTextButton()
        button.textColor = .appAccent
        button.setTitle(StringConsts.createAccBtnTxt, for: .normal)
        button.titleLabel?.font = loadFont(font: BaseFont.bold, size: DimenConsts.regularFontSize)
        
        // This will remove the padding from the button.
        // If all values are set to 0, the padding will be be set to it's default,
        // so the values have to be set the nearly 0 (0.01) for this to work.
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0.01, bottom: 0.01, right: 0)
        button.accessibilityIdentifier = "loginActionBtnId"
        return button
    }()
    
    lazy var emailTxt: SwarayTextField = {
        let textField = SwarayTextField()
        textField.font = loadFont(font: .regular, size: DimenConsts.largeFontSize)
        textField.setPlaceholder(placeholder: StringConsts.emailTxtPlaceholder)
        textField.returnKeyType = .done
        return textField
    }()
    
    lazy var emailValidationLabel: UILabel = {
        let label = UILabel()
        label.text = StringConsts.emailValidation
        label.textColor = .appAccent
        label.font = loadFont(font: .bold, size: DimenConsts.smallFontSize)
        label.alpha = 0
        return label
    }()
    
    lazy var passwordTxt: SwarayTextField = {
        let textField = SwarayTextField()
        textField.font = loadFont(font: .regular, size: DimenConsts.largeFontSize)
        textField.setPlaceholder(placeholder: StringConsts.passwordTxtPlaceholder)
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var passwordValidationLabel: UILabel = {
        let label = UILabel()
        label.text = StringConsts.passwordValidation
        label.textColor = .appAccent
        label.font = loadFont(font: .bold, size: DimenConsts.smallFontSize)
        label.alpha = 0
        return label
    }()
    
    lazy var passwordConfirmTxt: SwarayTextField = {
        let textField = SwarayTextField()
        textField.font = loadFont(font: .regular, size: DimenConsts.largeFontSize)
        textField.setPlaceholder(placeholder: StringConsts.pwConfirmTxtPlaceholder)
        textField.returnKeyType = .done
        textField.alpha = 0
        textField.isSecureTextEntry = true
        textField.accessibilityIdentifier = "confirmPwTxtId"
        return textField
    }()
    
    lazy var pwMatchValidationLabel: UILabel = {
        let label = UILabel()
        label.text = StringConsts.passwordMatchValidation
        label.textColor = .appAccent
        label.font = loadFont(font: .bold, size: DimenConsts.smallFontSize)
        label.alpha = 0
        return label
    }()
    
    // Make the button width the size of the screen with
    // a padding of 64 on each side
    private let signUpBtnWidth = UIScreen.main.bounds.width - (64 * 2)
    
    lazy var loginBtn: LoadingButton = {
        let button = LoadingButton()
        button.setTitle(StringConsts.loginBtnText, for: .normal)
        button.textColor = .white
        button.width = signUpBtnWidth
        button.titleLabel?.font = loadFont(font: .medium, size: DimenConsts.largeFontSize)
        button.backgroundColor = .appPrimary
        button.accessibilityIdentifier = "loginBtnId"
        return button
    }()

    override func addSubViews() {
        addSubview(background)
        addSubview(bottomHalfView)
        addSubview(loginLabel)
        addSubview(triangle)
        addSubview(actionLabel)
        addSubview(actionBtn)
        addSubview(emailTxt)
        addSubview(emailValidationLabel)
        addSubview(passwordTxt)
        addSubview(passwordValidationLabel)
        addSubview(passwordConfirmTxt)
        addSubview(pwMatchValidationLabel)
        bottomHalfView.addSubview(loginBtn)
    }
    // Keep track of the bottom constraint of background
    // for handling the state animation transition.
    var bgBottomConstraint: Constraint? = nil
    
    override func setupConstraints() {
        background.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(0)
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            bgBottomConstraint = make.bottom.equalTo(self.passwordTxt.snp.bottom).offset(144).constraint
        }
        
        bottomHalfView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.background.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        triangle.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            make.bottom.equalTo(self.background.snp.bottom).offset(0)
            make.height.equalTo(DimenConsts.triangleCutHeight)
        }

        loginLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(24)
            make.left.equalTo(self.snp.left).offset(24)
        }
        
        actionLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.loginLabel.snp.bottom).offset(4)
            make.left.equalTo(self.loginLabel.snp.left)
        }
        
        actionBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.actionLabel.snp.top)
            make.left.equalTo(self.actionLabel.snp.right)
        }
        
        emailTxt.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.actionLabel.snp.top).offset(48)
            make.left.equalTo(self.snp.left).offset(24)
            make.right.equalTo(self.snp.right).offset(-48)
        }
        
        emailValidationLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.emailTxt.snp.bottom).offset(4)
            make.left.equalTo(self.emailTxt.snp.left).offset(0)
        }
        
        passwordTxt.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.emailValidationLabel.snp.bottom).offset(8)
            make.left.equalTo(self.snp.left).offset(24)
            make.right.equalTo(self.snp.right).offset(-48)
        }
        
        passwordValidationLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.passwordTxt.snp.bottom).offset(4)
            make.left.equalTo(self.passwordTxt.snp.left).offset(0)
        }
        
        passwordConfirmTxt.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.passwordValidationLabel.snp.bottom).offset(8)
            make.left.equalTo(self.snp.left).offset(24)
            make.right.equalTo(self.snp.right).offset(-48)
        }
        
        pwMatchValidationLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.passwordConfirmTxt.snp.bottom).offset(4)
            make.left.equalTo(self.passwordConfirmTxt.snp.left).offset(0)
        }
        
        loginBtn.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.width.equalTo(signUpBtnWidth)
            make.center.equalTo(self.bottomHalfView.snp.center)
        }
    }
    
    override func transitionInViews() -> [UIView] {
        return [loginLabel, actionLabel, actionBtn, emailTxt, passwordTxt, loginBtn]
    }
}

// This exention is to handle animation related logic.
extension SignUpView {
    
    // Handle to tranistion from Login -> Sign Up and vice versa.
    // This handles constraint changes and fading in/out of Views on transition.
    func animateStateChange(state: LoginState) {
        triangle.snp.updateConstraints { (make) -> Void in
            make.height.equalTo( state == .signUp ? 0 : DimenConsts.triangleCutHeight)
        }
        
        bgBottomConstraint?.deactivate()
        background.snp.makeConstraints { (make) -> Void in
            let viewToConstrainTo = state == .signUp ? passwordConfirmTxt : passwordTxt
            bgBottomConstraint = make
                .bottom
                .equalTo(viewToConstrainTo.snp.bottom)
                .offset(state == .signUp ? 48 : 144)
                .constraint
        }
    
        // Exit animation
        startAnimation(duration: 0.5, anim: {
            if (state == .login) {
                self.emailValidationLabel.alpha = 0
                self.passwordValidationLabel.alpha = 0
                self.pwMatchValidationLabel.alpha = 0
                self.passwordConfirmTxt.alpha = 0
            }
        
            self.loginLabel.alpha = 0
            self.actionLabel.alpha = 0
            self.actionBtn.alpha = 0
            self.emailTxt.alpha = 0
            self.passwordTxt.alpha = 0
            self.loginBtn.alpha = 0
            self.layoutIfNeeded()

        }, finished: {
            self.loginLabel.text = state == .signUp ? StringConsts.signUpTitle : StringConsts.loginTitle
            self.actionLabel.text = state == .signUp ? StringConsts.hasAccountLabel : StringConsts.noAccountLabel
            self.actionBtn.setTitle(state == .signUp ? StringConsts.goToLoginBtnTxt : StringConsts.createAccBtnTxt, for: .normal)
            self.loginBtn.setTitle(state == .signUp ? StringConsts.signUpBtnText : StringConsts.loginBtnText, for: .normal)
            
            // Enter Animation. Performed after the exit anim
            self.startAnimation(duration: 0.25, anim: {
                self.loginLabel.alpha = 1
                self.actionLabel.alpha = 1
                self.actionBtn.alpha = 1
                self.emailTxt.alpha = 1
                self.passwordTxt.alpha = 1
                if (state == .signUp) {
                    self.passwordConfirmTxt.alpha = 1
                }
                self.loginBtn.alpha = 1
            })
        })
    }
    
    // Handles the exiting transiton to HomeController
    func handleExitAnimation(animationFinished: @escaping () -> Void) {
        bgBottomConstraint?.deactivate()
        background.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(
                (UIScreen.main.bounds.height * 0.6)
            )
        }
    
        setNeedsUpdateConstraints()
        startAnimation(duration: 0.5, anim: {
            self.layoutIfNeeded()
        }, finished: {
            self.handleExitAnimShrink(animationFinished: animationFinished)
        })
    }
    
    private func handleExitAnimShrink(animationFinished: @escaping () -> Void) {
        triangle.snp.updateConstraints { (make) -> Void in
            make.height.equalTo(DimenConsts.triangleCutHeight)
        }
    
        bgBottomConstraint?.deactivate()
        background.snp.updateConstraints { (make) -> Void in
            // This should be set to the same value as the HomeController
            make.height.equalTo(
                (UIScreen.main.bounds.height * 0.5)
            )
        }
        
        setNeedsUpdateConstraints()
        startAnimation(duration: 0.5, anim: {
            self.layoutIfNeeded()
            self.loginLabel.alpha = 0
            self.actionLabel.alpha = 0
            self.actionBtn.alpha = 0
            self.emailTxt.alpha = 0
            self.passwordTxt.alpha = 0
            self.passwordConfirmTxt.alpha = 0
            self.loginBtn.alpha = 0
        }, finished: {
            animationFinished()
        })
    }
}
