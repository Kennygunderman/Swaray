//
//  GoogleButton.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/20/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

// Google button that matches Google's branding standards found here:
// https://developers.google.com/identity/branding-guidelines#matching

import Foundation
import UIKit

class SocialButton: LoadingButton {
    
    private let customFont = FontUtil.loadFont(font: BaseFont.medium.rawValue, size: DimenConsts.regularFontSize)
    
    private let tile: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let socialIconImageView: UIImageView = {
        let imageView = UIImageView()
        
        // Height & width of button must be 18
        imageView.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        return imageView
    }()
    
    private lazy var customTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = customFont
        return label
    }()
    
    var tileColor: UIColor = .white {
        didSet {
            tile.backgroundColor = tileColor
        }
    }
    
    var logo: UIImage? {
        didSet {
            socialIconImageView.image = logo
        }
    }
    
    override var textColor: UIColor {
        didSet {
            self.customTitleLabel.textColor = textColor
        }
    }
    
    override var cornerRadius: CGFloat {
        return 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadingButtonWidth = 40
        addViews()
    }
    
    override func setTitle(title: String) {
        self.customTitleLabel.text = title
    }
    
    func addViews() {
        addSubview(customTitleLabel)
        addSubview(tile)
        tile.addSubview(socialIconImageView)
    
        tile.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(2)
            make.top.equalTo(self.snp.top).offset(2)
            make.bottom.equalTo(self.snp.bottom).offset(-2)
            make.width.equalTo(40)
        }
        
        socialIconImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self.tile.snp.center)
        }
        customTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(socialIconImageView.snp.right).offset(24)
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-8)
        }
    }
    
    
    override func animate() {
        super.animate()
        
        if (buttonState == .loading) {
            tile.alpha = 0
        } else {
            tile.alpha = 1
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
