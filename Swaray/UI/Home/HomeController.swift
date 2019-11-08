//
//  HomeController.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/16/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit

class HomeController: BaseController<HomeView, HomeViewModel> {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        baseView.hostingBtn.addTarget(self, action: #selector(test), for: .touchUpInside)
        
       
    }
    
    @objc func test() {
        baseView.handleExitAnimation {
            
        }
    }
}

class HomeViewModel {}
