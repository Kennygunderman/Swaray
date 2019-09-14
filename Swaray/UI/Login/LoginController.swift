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
        
        baseView.button.addTarget(self, action: #selector(handle), for: .touchUpInside)

        
      }
    
    var flag: Bool = true
    
    @objc func handle() {

        
        self.baseView.triangle.snp.updateConstraints { (make) -> Void in
            make.height.equalTo( flag ? 0 : 150)
            
            flag = !flag
        }
        self.view.setNeedsUpdateConstraints()
        
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            
            self.view.layoutIfNeeded()

        }, completion: nil)
    }
}
