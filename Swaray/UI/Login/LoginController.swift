//
//  ViewController.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/13/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import UIKit
import SnapKit

class LoginController: BaseController<LoginView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }

    private func setupActions() {
        baseView.createAccBtn
            .addTarget(self, action: #selector(handleCreate), for: .touchUpInside)
    }
    
    @objc func handleCreate() {
        baseView.handleExitAnimation {
            let controller = SignUpController()
            self.navigationController?.pushViewController(controller, animated: false)
        }
    }
}
