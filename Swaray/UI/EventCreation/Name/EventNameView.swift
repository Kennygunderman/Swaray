//
//  EventNameView.swift
//  Swaray
//
//  Created by Kenny Gunderman on 11/8/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit

class EventNameView: BaseControllerView<EventNameViewModel>, UITextFieldDelegate {
    lazy var actionLabel: UILabel = {
        let label = UILabel()
        label.text = StringConsts.eventNameLabel
        label.textColor = .black
        label.font = FontUtil.loadFont(font: .demiBold, size: DimenConsts.regularFontSize)
        return label
    }()
    
    lazy var eventNameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        viewModel?.name.bidirectionalBind(to: textField.reactive.text)
        textField.font = FontUtil.loadFont(font: .regular, size: DimenConsts.subHeaderFontSize)
        textField.attributedPlaceholder = NSAttributedString(
            string: StringConsts.eventCreationNameHint,
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        textField.delegate = self
        textField.returnKeyType = .next
        return textField
    }()
    
    lazy var validationLabel: UILabel = {
        let label = UILabel()
        viewModel?.nameValidation.bind(to: label.reactive.alpha)
        label.text = StringConsts.eventNameValidationLavel
        label.textColor = .appAccent
        label.font = FontUtil.loadFont(font: .bold, size: DimenConsts.smallFontSize)
        return label
    }()
    
    override func transitionInViews() -> [UIView] {
        return [actionLabel, eventNameTextField]
    }

    override func addSubViews() {
        super.addSubViews()
        addSubview(eventNameTextField)
        addSubview(actionLabel)
        addSubview(validationLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        eventNameTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(-64)
            make.left.equalTo(self.snp.left).offset(24)
            make.right.equalTo(self.snp.right).offset(-24)
        }
        
        actionLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(eventNameTextField.snp.top).offset(0)
            make.left.equalTo(eventNameTextField.snp.left)
        }
        
        validationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(eventNameTextField.snp.bottom)
            make.left.equalTo(eventNameTextField.snp.left)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return viewModel?.validateName() ?? false
    }
}
