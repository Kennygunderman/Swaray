//
//  EventDateView.swift
//  Swaray
//
//  Created by Kenny Gunderman on 11/10/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import UIKit

class EventDateView: BaseControllerView<EventDateViewModel> {
    lazy var actionLabel: UILabel = {
        let label = UILabel()
        label.text = StringConsts.eventDateLabel
        label.textColor = .black
        label.font = FontUtil.loadFont(font: .demiBold, size: DimenConsts.regularFontSize)
        return label
    }()
    
    lazy var eventDateTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        viewModel?.date.bidirectionalBind(to: textField.reactive.text)
        textField.font = FontUtil.loadFont(font: .regular, size: DimenConsts.subHeaderFontSize)
        textField.attributedPlaceholder = NSAttributedString(
            string: StringConsts.eventCreationDateHint,
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        
        //set the text input to display a DatePicker
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        datePickerView.addTarget(self, action: #selector(dateChanged(sender:)), for: .valueChanged)
        textField.inputView = datePickerView
        
        return textField
    }()
    
    lazy var validationLabel: UILabel = {
        let label = UILabel()
        viewModel?.dateValidation.bind(to: label.reactive.alpha)
        label.text = StringConsts.eventDateValidationLavel
        label.textColor = .appAccent
        label.font = FontUtil.loadFont(font: .bold, size: DimenConsts.smallFontSize)
        return label
    }()
    
    @objc func dateChanged(sender: UIDatePicker) {
        viewModel?.formatDate(sender.date)
    }
    
    override func addSubViews() {
        super.addSubViews()
        addSubview(eventDateTextField)
        addSubview(actionLabel)
        addSubview(validationLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        eventDateTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(-64)
            make.left.equalTo(self.snp.left).offset(24)
            make.right.equalTo(self.snp.right).offset(-24)
        }
        
        actionLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(eventDateTextField.snp.top).offset(0)
            make.left.equalTo(eventDateTextField.snp.left)
        }
        
        validationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(eventDateTextField.snp.bottom)
            make.left.equalTo(eventDateTextField.snp.left)
        }
    }
}
