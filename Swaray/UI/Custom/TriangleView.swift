//
//  TriangleView.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/13/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit

class TriangleView : UIView {
    var color: CGColor? = nil
    
    init(color: CGColor, frame: CGRect) {
        super.init(frame: frame)
        self.color = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: (rect.maxX), y: rect.minY))
        context.closePath()
        
        if let color = self.color {
            context.setFillColor(color)
        }
        
        context.fillPath()
    }
}

