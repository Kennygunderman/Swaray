//
//  LoginView.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/13/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class LoginView: BaseControllerView {
    lazy var loginBg: UIView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let view = UIView(frame: frame)
        view.backgroundColor = .appPrimary
        return view
    }()
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = StringConsts.loginTitle
        label.textColor = .white
        label.font = loadFont(font: BaseFont.regular, size: DimenConsts.headerFontSize)
        label.alpha = 0
        return label
    }()
    
    // This is the magic view that creates the diagonal in the layout
    let triangle: TriangleView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let color = UIColor.white.cgColor
        let triangle = TriangleView(color: color, frame: frame)
        triangle.backgroundColor = .appPrimary
        return triangle
    }()
    
    lazy var noAccLabel: UILabel = {
        let label = UILabel()
        label.text = StringConsts.noAccountLabel
        label.textColor = .white
        label.font = loadFont(font: BaseFont.regular, size: DimenConsts.regularFontSize)
        label.alpha = 0
        return label
    }()
    
    // Button for creating an account
    lazy var createAccBtn: UIButton = {
        let button = UIButton()
        button.setTitle(StringConsts.createAccBtnTxt, for: .normal)
        button.setTitleColor(.appAccent, for: .normal)
        button.titleLabel?.font = loadFont(font: BaseFont.bold, size: DimenConsts.regularFontSize)
        
        // This will remove the padding from the button.
        // If all values are set to 0, the padding will be be set to it's default,
        // so the values have to be set the nearly 0 (0.01) for this to work.
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0.01, bottom: 0.01, right: 0)
        button.alpha = 0
        return button
    }()
    
    override func addSubViews() {
        addSubview(loginBg)
        addSubview(loginLabel)
        addSubview(triangle)
        addSubview(noAccLabel)
        addSubview(createAccBtn)
    }
    
    override func setupConstraints() {
        loginBg.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(0)
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            
            //set the height to 50% of the screen height
            make.height.equalTo(
                (UIScreen.main.bounds.height * 0.5)
            )
        }
        
        triangle.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            make.bottom.equalTo(self.loginBg.snp.bottom).offset(0)
            make.height.equalTo(150)
        }
        
        loginLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(24)
            make.left.equalTo(self.snp.left).offset(24)
        }
        
        noAccLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.loginLabel.snp.bottom).offset(4)
            make.left.equalTo(self.loginLabel.snp.left)
        }
        
        createAccBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.noAccLabel.snp.top)
            make.left.equalTo(self.noAccLabel.snp.right)
        }
    }
    
    override func viewsToAnimate() -> [UIView] {
        return [noAccLabel, createAccBtn, loginLabel]
    }
}

// This exention on LoginView is to handle Animation related logic.
extension LoginView {
    
    // Updates & animates constraint changes on the view
    // needed for transitioning.
    func handleExitAnimation(animationFinished: @escaping () -> Void) {
        triangle.snp.updateConstraints { (make) -> Void in
            make.height.equalTo(0)
        }
        
        loginBg.snp.updateConstraints { (make) -> Void in
            make.height.equalTo((UIScreen.main.bounds.height * 0.6))
        }
        
        loginLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(0)
        }
        
        setNeedsUpdateConstraints()
        startAnimation(duration: 0.5, anim: {
            self.noAccLabel.alpha = 0
            self.createAccBtn.alpha = 0
            self.layoutIfNeeded()
        }, finished: {
            animationFinished()
            self.resetViews()
        })
    }
    
    // Reset all the subview's back to their original state.
    // This is needed for when the LoginController is popped.
    fileprivate func resetViews() {
        // re-apply constraints
        for view in self.subviews {
            view.snp.removeConstraints()
        }
        
        self.setupConstraints()
    }
}
