//
//  BaseControler.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/13/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit

class BaseController<T_VIEW: BaseControllerView>: UIViewController {
    
    // baseView used on controller.
    // access this whenever needing to manipulate/access the
    // root view for controller. Never call explicitly `self.view`.
    // when using this Base implementation.
    lazy var baseView: T_VIEW = T_VIEW()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = baseView
    }
}
