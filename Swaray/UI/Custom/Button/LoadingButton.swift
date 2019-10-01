//
//  SwarayButton.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/15/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit


// UIButton that turns into a loading indicator
class LoadingButton: SwarayButton {
    enum ButtonState {
        case loading
        case regular
    }
    
    // The width of the button when it returns back to it's
    // regular state
    var width: CGFloat = 300 //default
    
    // Width of button when it's in its loading state
    private var loadingButtonWidth: CGFloat = 50

    private let animationDuration: Double = 0.3
    private var buttonState: ButtonState = .regular

    
    // Animate's button into a spinner view. In order for this to work
    // the button must be constrained properly.
    func animate() {
        if (buttonState == .regular) {
            buttonState = .loading
            let spinner = UIActivityIndicatorView()
            spinner.isUserInteractionEnabled = false
            self.addSubview(spinner)
            
            snp.updateConstraints { (make) -> Void in
                make.width.equalTo(loadingButtonWidth)
            }
            
            spinner.snp.makeConstraints { (make) -> Void in
                make.center.equalTo(snp.center)
            }
            
            spinner.color = .white
            spinner.startAnimating()
            spinner.alpha = 0
            
            UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.textColor = .clear
                self.layer.cornerRadius = self.loadingButtonWidth / 2
                spinner.alpha = 1
                self.layoutIfNeeded()
            }, completion: nil)
        } else {
            buttonState = .regular
            
            snp.updateConstraints { (make) -> Void in
                make.width.equalTo(width)
            }
            
            UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                for subview in self.subviews where subview is UIActivityIndicatorView {
                    subview.removeFromSuperview()
                }
                
                self.textColor = .white
                self.layer.cornerRadius = self.cornerRadius
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
}
