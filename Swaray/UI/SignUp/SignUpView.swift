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
    lazy var signUpBg: UIView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let view = UIView(frame: frame)
        view.backgroundColor = .appPrimary
        return view
    }()
    
    // This is the magic view that creates the diagonal in the layout
    let triangle: TriangleView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let color = UIColor.white.cgColor
        let triangle = TriangleView(color: color, frame: frame)
        triangle.backgroundColor = .appPrimary
        triangle.alpha = 0
        return triangle
    }()
    
    lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = StringConsts.signUpTitle
        label.textColor = .white
        label.font = loadFont(font: BaseFont.regular, size: DimenConsts.headerFontSize)
        return label
    }()
    
    lazy var hasAccLabel: UILabel = {
        let label = UILabel()
        label.text = StringConsts.hasAccountLabel
        label.textColor = .white
        label.font = loadFont(font: BaseFont.regular, size: DimenConsts.regularFontSize)
        return label
    }()
    
    // Button for returning back to login
    lazy var returnToLoginBtn: UIButton = {
        let button = UIButton()
        button.setTitle(StringConsts.goToLoginBtnTxt, for: .normal)
        button.setTitleColor(.appAccent, for: .normal)
        button.titleLabel?.font = loadFont(font: BaseFont.bold, size: DimenConsts.regularFontSize)
        
        // This will remove the padding from the button.
        // If all values are set to 0, the padding will be be set to it's default,
        // so the values have to be set the nearly 0 (0.01) for this to work.
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0.01, bottom: 0.01, right: 0)
        return button
    }()
    
    lazy var emailTxt: SwarayTextField = {
        let textField = SwarayTextField()
        textField.font = loadFont(font: .regular, size: DimenConsts.largeFontSize)
        textField.setPlaceholder(placeholder: StringConsts.emailTxtPlaceholder)
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
        textField.isSecureTextEntry = true
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
    
    lazy var signUpBtn: UIButton = {
        let button = UIButton()
        button.setTitle(StringConsts.signUpBtnText, for: .normal)
        button.setTitleColor(.appAccent, for: .normal)
        button.titleLabel?.font = loadFont(font: .regular, size: DimenConsts.regularFontSize)
        return button
    }()

    override func addSubViews() {
        addSubview(signUpBg)
        addSubview(signUpLabel)
        addSubview(triangle)
        addSubview(hasAccLabel)
        addSubview(returnToLoginBtn)
        addSubview(emailTxt)
        addSubview(emailValidationLabel)
        addSubview(passwordTxt)
        addSubview(passwordValidationLabel)
        addSubview(passwordConfirmTxt)
        addSubview(pwMatchValidationLabel)
        addSubview(signUpBtn)
    }
    
    override func setupConstraints() {
        signUpBg.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(0)
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            
            // set the height to 55% of the screen height.
            // This should match the transition animation height
            // in LoginView.
            make.height.equalTo(
                (UIScreen.main.bounds.height * 0.6)
            )
        }
        
        triangle.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            make.bottom.equalTo(self.signUpBg.snp.bottom).offset(0)
            make.height.equalTo(150)
        }

        signUpLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(24)
            make.left.equalTo(self.snp.left).offset(24)
        }
        
        hasAccLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.signUpLabel.snp.bottom).offset(4)
            make.left.equalTo(self.signUpLabel.snp.left)
        }
        
        returnToLoginBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.hasAccLabel.snp.top)
            make.left.equalTo(self.hasAccLabel.snp.right)
        }
        
        emailTxt.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.hasAccLabel.snp.top).offset(48)
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
        
        signUpBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.signUpBg.snp.bottom).offset(24)
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
    }
    
    override func viewsToAnimate() -> [UIView] {
        return [signUpLabel, hasAccLabel, returnToLoginBtn, emailTxt, passwordTxt, passwordConfirmTxt, signUpBtn]
    }
}

// This exention on SignUpView is to handle animation related logic.
extension SignUpView {
    
    // Updates & animates constraint changes on the view
    // when exiting.
    func handleExitAnimation(animationFinished: @escaping () -> Void) {
        
        // This get's a little weird. But here we need to set the height constraint of
        // the triangle view to 0 and call `layoutIfNeeded()`. This will automatically
        // set the triangle view to have a height of 0. After setting the height to 0,
        // we can set the alpha of the view to 1, and animate the height change to the user.
        // We need to do this for the animation to work properly.
        triangle.snp.updateConstraints { (make) -> Void in
            make.height.equalTo(0)
        }
        
        layoutIfNeeded()
        triangle.alpha = 1
        
        triangle.snp.updateConstraints { (make) -> Void in
            make.height.equalTo(150) //This should equal the default height in Login.
        }
        
        signUpBg.snp.updateConstraints { (make) -> Void in
            make.height.equalTo(
                (UIScreen.main.bounds.height * 0.5)
            )
        }

        signUpLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(0)
        }
        
        setNeedsUpdateConstraints()
        startAnimation(duration: 0.5, anim: {
            self.emailTxt.alpha = 0
            self.passwordTxt.alpha = 0
            self.passwordConfirmTxt.alpha = 0
            self.hasAccLabel.alpha = 0
            self.returnToLoginBtn.alpha = 0
            self.signUpBtn.alpha = 0
            self.emailValidationLabel.alpha = 0
            self.passwordValidationLabel.alpha = 0
            self.pwMatchValidationLabel.alpha = 0
            self.layoutIfNeeded()
        }, finished: {
            animationFinished()
        })
    }
}
