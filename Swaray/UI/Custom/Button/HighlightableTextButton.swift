//
//  HighlightableTextButton.swift
//  Swaray
//
//  Created by Kenny Gunderman on 10/1/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit

// UIButton that highlights text when pressed
class HighlightableTextButton: UIButton {
    var textColor: UIColor = .appPrimary {
        didSet {
            self.setTitleColor(self.textColor, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
