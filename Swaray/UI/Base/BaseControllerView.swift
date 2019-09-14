//
//  BaseView.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/13/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit

class BaseControllerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setupConstraints()
    }
    
    // This method should be used for adding subViews in the
    // when BaseControllerView is implemented. Hence the name
    // `addSubViews` :D
    func addSubViews() {
        
    }
    
    // Called once the sub views have been added,
    // this method should be used for setting up constraints
    // of said sub views.
    func setupConstraints() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
