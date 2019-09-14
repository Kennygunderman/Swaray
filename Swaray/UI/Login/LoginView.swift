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
        return label
    }()

    let triangle: TriangleView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let color = UIColor.white.cgColor
        let triangle = TriangleView(color: color, frame: frame)
        triangle.backgroundColor = .appPrimary
        return triangle
    }()
    
    let button: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .blue
        return btn
    }()
    
    override func addSubViews() {
        addSubview(loginBg)
        addSubview(loginLabel)
        addSubview(triangle)
        addSubview(button)
    }
    
    override func setupConstraints() {
        loginBg.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(DimenConsts.toolbarHeight)
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            
            //set the height to 60% of the screen height
            make.height.equalTo(
                (UIScreen.main.bounds.height * 0.60) - DimenConsts.toolbarHeight
            )
        }
        
        triangle.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            make.bottom.equalTo(self.loginBg.snp.bottom).offset(0)
            make.height.equalTo(150)
        }
        
        loginLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(DimenConsts.toolbarHeight + 24)
            make.left.equalTo(self.snp.left).offset(24)
        }
    }
}
