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
    
    // baseView used on Controller.
    // Access this whenever needing to manipulate/access the
    // root view for controller. Never explicitly call `self.view`
    // when using this base implementation.
    lazy var baseView: T_VIEW = T_VIEW()
    
    // The default title view for each ViewController
    lazy var defaultTitleView: UILabel = {
        let label = UILabel()
        label.text = StringConsts.appName
        label.textColor = .white
        label.font = baseView.loadFont(font: BaseFont.bold, size: DimenConsts.subHeaderFontSize)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = baseView
        setTitleView()
    }
    
    fileprivate func setTitleView() {
        self.navigationItem.titleView = getTitleView()
    }
    
    // This function should be overriden when a custom view is
    // need for the title.
    func getTitleView() -> UIView {
       return defaultTitleView
    }
    
    // Default the status bar to light themed
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
