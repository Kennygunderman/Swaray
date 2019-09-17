//
//  Spinner.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/15/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit
import SnapKit


extension UIButton {
    
//    func animate() {
//
//        self.setTitleColor(.black, for: .normal)
//
//        self.setTitle("", for: .normal)
//
//        let spinner = UIActivityIndicatorView()
//        spinner.isUserInteractionEnabled = false
//
//       // self.translatesAutoresizingMaskIntoConstraints = false
//       // spinner.translatesAutoresizingMaskIntoConstraints = false
//
//
//
//        self.addSubview(spinner)
//
//
//        snp.makeConstraints { (make) -> Void in
//            make.width.equalTo(50)
//        }
//
//        spinner.snp.makeConstraints { (make) -> Void in
//            make.center.equalTo(snp.center)
//        }
//
//
//        spinner.color = .white
//        spinner.startAnimating()
//        spinner.alpha = 0
//
//        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//           self.setTitleColor(.clear, for: .normal)
//            self.layer.cornerRadius = 25
//            spinner.alpha = 1
//            self.layoutIfNeeded()
//        }, completion: nil)
//
//    }
}

extension UIButton {
    
    
    
    func animateWhileAwaitingResponse(showLoading: Bool, originalConstraints: [NSLayoutConstraint]) {
        
        
        
        let spinner = UIActivityIndicatorView()
        spinner.isUserInteractionEnabled = false
        
        // Constraints which will add in supper view
        let constraints = [
            NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: self.superview, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: self.superview, attribute: .centerY, multiplier: 1, constant: 0),
            
            NSLayoutConstraint(item: spinner, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: spinner, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: spinner, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 45),
            NSLayoutConstraint(item: spinner, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 45)
        ]
        
        // Constrains which will add in button
        let selfCostraints = [
            NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 45),
            NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 45),
        ]
        
        // Keeping this outside of condition due to adding constrains programatically.
        self.translatesAutoresizingMaskIntoConstraints = false
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        if showLoading {
            
            // Remove width constrains of button from superview
            // Identifier given in storyboard constrains
            self.superview?.constraints.forEach({ (constraint) in
                if constraint.identifier == "buttonWidth" {
                    constraint.isActive = false
                }
            })
            
            NSLayoutConstraint.deactivate(self.constraints)
            
            self.addSubview(spinner)
            self.superview?.addConstraints(constraints)
            self.addConstraints(selfCostraints)
            spinner.color = .white
            spinner.startAnimating()
            spinner.alpha = 0
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.setTitleColor(.clear, for: .normal)
                self.layer.cornerRadius = 22.5
                spinner.alpha = 1
                self.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                
                for subview in self.subviews where subview is UIActivityIndicatorView {
                    subview.removeFromSuperview()
                }
                
                self.removeConstraints(selfCostraints)
                NSLayoutConstraint.deactivate(self.constraints)
                self.setTitleColor(.white, for: .normal)
                self.superview?.addConstraints(originalConstraints)
                NSLayoutConstraint.activate(originalConstraints)
                self.layer.cornerRadius = 0
                
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
}
