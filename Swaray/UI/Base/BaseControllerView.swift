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
    
    // This method should be used for adding sub views
    // when BaseControllerView is implemented. Hence the name
    // `addSubViews` :D
    func addSubViews() {
        
    }
    
    // Called once the sub views have been added.
    // This method should be used for setting up constraints
    // of said sub views.
    func setupConstraints() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadFont(font: BaseFont, size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: font.rawValue, size: size) else {
            fatalError("""
        Failed to load the "\(font.rawValue)" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
            )
        }
        return customFont
    }
}
