//
//  EventNameViewModel.swift
//  Swaray
//
//  Created by Kenny Gunderman on 11/8/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import Bond

class EventNameViewModel {
    let name = Observable<String?>("")
    let nameValidation = Observable<CGFloat>(0)
    let navigateTrigger = Observable<Bool>(false)
    
    init() {
        _ = name.observeNext { _ in
            if self.nameValidation.value == 1
                && self.validateName() {
                self.setNameValidation(withValueToAnimate: 0)
            }
        }
    }
    
    /**
     Handles logic for when Next button is tapped.
     Check's validation for Name text field, and notifies navigation observer
     if valid. If not valid, notfies validation label.
     
     - Returns: Whether validation passes.
     */
    func handleNext() -> Bool {
        let isValid = validateName()
        if isValid {
            navigateTrigger.value = true
        } else {
            self.setNameValidation(withValueToAnimate: 1)
        }
        return isValid
    }

    //Check's if name value is empty or null
    private func validateName() -> Bool {
        return !(name.value?.isEmpty ?? true)
    }
    
    //Set's the nameValidation Observer using an animation
    private func setNameValidation(withValueToAnimate: CGFloat) {
        UIView.animate(withDuration: 0.25, animations: {
            self.nameValidation.value = withValueToAnimate
        })
    }
}
