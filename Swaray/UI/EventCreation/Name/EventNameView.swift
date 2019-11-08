//
//  EventNameView.swift
//  Swaray
//
//  Created by Kenny Gunderman on 11/8/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit

class EventNameView: BaseControllerView<EventNameViewModel> {
    
    lazy var actionLabel: UILabel = {
        let label = UILabel()
        label.text = StringConsts.eventNameLabel
        label.textColor = .black
        label.font = FontUtil.loadFont(font: .demiBold, size: DimenConsts.regularFontSize)
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = FontUtil.loadFont(font: .regular, size: DimenConsts.subHeaderFontSize)
        textField.attributedPlaceholder = NSAttributedString(
            string: StringConsts.eventCreationNameHint,
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        textField.returnKeyType = .next
        return textField
    }()
    
    
    override func addSubViews() {
        super.addSubViews()
        addSubview(textField)
        addSubview(actionLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        textField.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(-64)
            make.left.equalTo(self.snp.left).offset(24)
            make.right.equalTo(self.snp.right).offset(-24)
        }
        
        actionLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(textField.snp.top).offset(0)
            make.left.equalTo(textField.snp.left)
        }
    }
}
