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
    
    init() {
        _ = name.observeNext { _ in
            if self.nameValidation.value == 1
                && self.validateName() {
                self.setNameValidation(withValueToAnimate: 0)
            }
        }
    }

    func validateName() -> Bool {
        let isNameEmpty = name.value?.isEmpty ?? true
        
        if (isNameEmpty) {
            self.setNameValidation(withValueToAnimate: 1)
        }
        
        return !isNameEmpty
    }
    
    
    //Set's the nameValidation Observer using an animation
    private func setNameValidation(withValueToAnimate: CGFloat) {
        UIView.animate(withDuration: 0.25, animations: {
            self.nameValidation.value = withValueToAnimate
        })
    }
}
