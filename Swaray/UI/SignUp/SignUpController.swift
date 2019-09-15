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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    fileprivate func setupActions() {
        baseView.returnToLoginBtn
            .addTarget(self, action: #selector(handleReturnToLogin), for: .touchUpInside)
    }
    
    @objc func handleReturnToLogin() {
        
        baseView.handleExitAnimation {
            self.navigationController?.popViewController(animated: false)
        }
        
    }
}
