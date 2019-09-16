//
//  SwarayButton.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/15/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit

// UIButton with a radius and shadow
class SwarayButton: HighlightableTextButton {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = 4
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 0.75
        layer.masksToBounds = false
    }
}

// UIButton that highlights text when pressed
class HighlightableTextButton: UIButton {
    var textColor: UIColor = .appPrimary

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.setTitleColor(self.textColor, for: .normal)
    }
    
    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted) {
                self.setTitleColor(self.textColor.withAlphaComponent(0.75), for: .normal)
            }
            else {
                self.setTitleColor(self.textColor, for: .normal)
            }
        }
    }
}
