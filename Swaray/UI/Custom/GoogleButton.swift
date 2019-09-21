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

class GoogleButton: UIView {
    
    private let cornerRadius: CGFloat = 2
    
    //TODO: move to load font function. Move load font into util
    // Default font for the Google Button is `Roboto-Medium`
    private let font = UIFont(name: "Roboto-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)
    
    let tile: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 2
        return view
    }()
    
    let googleImageView: UIImageView = {
        let logo: UIImage = UIImage(named:"google-logo")!
        let imageView = UIImageView()
        imageView.image = logo
        
        // Height & width of button must be 18
        imageView.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        return imageView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = font
        return label
    }()
    
    
    func setTitle(title: String) {
        self.title.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 0.75
        self.layer.masksToBounds = false
        self.backgroundColor = .rgb(red: 66, green: 133, blue: 244)
        addViews()
    }
    
    func addViews() {
        addSubview(title)
        addSubview(tile)
        tile.addSubview(googleImageView)
    
        tile.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(2)
            make.top.equalTo(self.snp.top).offset(2)
            make.bottom.equalTo(self.snp.bottom).offset(-2)
            make.width.equalTo(40)
        }
        
        googleImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self.tile.snp.center)
        }
        title.snp.makeConstraints { (make) in
            make.left.equalTo(googleImageView.snp.right).offset(24)
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-8)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
