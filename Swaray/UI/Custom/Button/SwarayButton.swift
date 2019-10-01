//
//  SwarayButton.swift
//  Swaray
//
//  Created by Kenny Gunderman on 10/1/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit


// Default button layout with a corner radius and background shadow
class SwarayButton: UIButton {
    var textColor: UIColor = .appPrimary {
        didSet {
            self.setTitleColor(self.textColor, for: .normal)
        }
    }
    
    // Corner radius of button, default is 4
    var cornerRadius: CGFloat {
        return 4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = cornerRadius
        self.addShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addShadow() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 0.75
        self.layer.masksToBounds = false
    }
    
    func setTitle(title: String) {
        self.setTitle(title, for: .normal)
    }
}
