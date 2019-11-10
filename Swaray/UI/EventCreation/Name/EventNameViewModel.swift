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
                self.nameValidation.value = 0
            }
        }
    }

    func validateName() -> Bool {
        let isNameEmpty = name.value?.isEmpty ?? true
        
        if (isNameEmpty) {
            nameValidation.value = 1
        }
        
        return !isNameEmpty
    }
}
