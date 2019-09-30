//
//  FontUtil.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/30/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit

enum FontUtil {
    static func loadFont(font: BaseFont, size: CGFloat) -> UIFont {
        return loadFont(font: font.rawValue, size: size)
    }
    
    static func loadFont(font: String, size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: font, size: size) else {
            fatalError("""
                Failed to load the "\(font)" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return customFont
    }
}
