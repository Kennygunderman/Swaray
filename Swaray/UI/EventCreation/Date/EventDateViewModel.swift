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
    let alertError = Observable<UIAlertController?>(nil)
      
    let dateFormatter: DateFormatter
    let eventCreator: EventCreator
    let eventRepository: EventRepository
    
    var eventName: String = ""
    
    init(dateFormatter: DateFormatter = getDateFormatter(),
         eventCreator: EventCreator = getEventCreator(),
         eventRepository: EventRepository = getEventRepo()) {
        self.dateFormatter = dateFormatter
        self.eventCreator = eventCreator
        self.eventRepository = eventRepository
    
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
    
    func saveEvent() {
        if validateDate() {
            let (eventStatus, event) = eventCreator.createEvent(
                name: eventName,
                date: date.value ?? ""
            )
        
            if (event != nil && eventStatus == .success) {
                //safe to force unwrap here
                saveToFirestore(event: event!)
            } else {
                handleInvalidEvent(status: eventStatus)
            }
        }
    }
    
    private func saveToFirestore(event: Event) {
        eventRepository.save(event: event) { event, err in
            if let _ = err {
                self.alertError.value = self.createAlertError(
                    title: "save err",
                    error: err?.localizedDescription ?? "Generic Error here"
                )
            } else {
                //todo: post a value to success
                self.alertError.value = self.createAlertError(
                    title: "save err",
                    error: err?.localizedDescription ?? "Generic Error here"
                )
            }
        }
    }
    
    private func handleInvalidEvent(status: EventCreationStatus) {
        if (status == .invalidUser) {
            self.alertError.value = self.createAlertError(
                title: "Creation error",
                error: "Invalid user was found please try relogging..."
            )
        } else if (status == .invalidDate) {
            self.alertError.value = self.createAlertError(
                title: "Creation error",
                error: "Invalid date found. Please check the date and try again"
            )
        }
    }
    
    private func createAlertError(title: String, error: String) -> UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: error,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        return alert
    }
}

