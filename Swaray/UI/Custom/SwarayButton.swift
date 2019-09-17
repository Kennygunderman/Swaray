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
class LoadingButton: UIButton {
    private enum ButtonState {
        case loading
        case regular
    }
    
    var textColor: UIColor = .appPrimary {
        didSet {
            self.setTitleColor(self.textColor, for: .normal)
        }
    }

    // The width of the button when it returns back to it's
    // regular state
    var width: CGFloat = 300 //default
    
    private var buttonState: ButtonState = .regular
    private let cornerRadius: CGFloat = 4
    private let animationDuration: Double = 0.3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 0.75
        self.layer.masksToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Animate's button into a spinner view. In order for this to work
    // the button must be constrained properly with a with constraint.
    func animate() {
        if (buttonState == .regular) {
            buttonState = .loading
            let spinner = UIActivityIndicatorView()
            spinner.isUserInteractionEnabled = false
            self.addSubview(spinner)
            
            snp.updateConstraints { (make) -> Void in
                make.width.equalTo(50)
            }
            
            spinner.snp.makeConstraints { (make) -> Void in
                make.center.equalTo(snp.center)
            }
            
            spinner.color = .white
            spinner.startAnimating()
            spinner.alpha = 0
            
            UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.textColor = .clear
                self.layer.cornerRadius = 25
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
