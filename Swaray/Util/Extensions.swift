//
//  Extensions.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/14/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    // Color palette for Application
    static let appPrimary = rgb(red: 66, green: 14, blue: 194)
    static let appAccent = rgb(red: 229, green: 57, blue: 53)
    static let textDark = UIColor(red: 1, green: 1, blue: 1, alpha: 0.87)
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UINavigationController {
    // This handles setting the status bar to the preferred style set
    // In the ViewController.
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
