//
//  EventDateViewModel.swift
//  Swaray
//
//  Created by Kenny Gunderman on 11/10/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import Bond

class EventDateViewModel {
    let date = Observable<String?>("")
    let dateValidation = Observable<CGFloat>(0)
      
    let dateFormatter: DateFormatter
    init(dateFormatter: DateFormatter = getDateFormatter()) {
        self.dateFormatter = dateFormatter
        
        _ = date.observeNext { _ in
            if self.dateValidation.value == 1
                && self.validateDate() {
                self.setDateValidation(withValueToAnimate: 0)
            }
        }
    }
    
    func validateDate() -> Bool {
        let isDateEmpty = date.value?.isEmpty ?? true
        
        if (isDateEmpty) {
            self.setDateValidation(withValueToAnimate: 1)
        }
        
        return !isDateEmpty
    }
    
    func formatDate(_ date: Date) {
        self.date.value = dateFormatter.string(from: date)
    }
    
    //Set's the nameValidation Observer using an animation
    private func setDateValidation(withValueToAnimate: CGFloat) {
        UIView.animate(withDuration: 0.25, animations: {
            self.dateValidation.value = withValueToAnimate
        })
    }
}

