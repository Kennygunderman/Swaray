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
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = StringConsts.loginTitle
        label.font = UIFont.systemFont(ofSize: DimenConsts.headerFontSize)
        return label
    }()
    
    override func addSubviews() {
        addSubview(loginLabel)
    }
    
    override func setupConstraints() {
        loginLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(snp.top).offset(DimenConsts.toolbarHeight + 24)
            make.left.equalTo(snp.left).offset(24)
        }
    }
}
