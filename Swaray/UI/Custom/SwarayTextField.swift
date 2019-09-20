//
//  SwarayTextField.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/14/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit

class SwarayTextField: UITextField {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addBottomLine()
        textColor = .white
    }
    
    // Sets the TextField's placeholder text and color
    func setPlaceholder(placeholder: String) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.lightGray]
        )
    }
    
    // Add a line to the bottom of TextField
    fileprivate func addBottomLine() {
        let color: UIColor = .lightGray
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: bounds.size.height - 1, width: bounds.size.width, height: 2)
        bottomBorder.backgroundColor = color.cgColor
        self.layer.addSublayer(bottomBorder)
    }
}
