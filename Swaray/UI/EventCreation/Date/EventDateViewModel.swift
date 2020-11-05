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
    let alert = Observable<UIAlertController?>(nil)
      
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
                self.alert.value = self.createAlert(
                    title: StringConsts.firestoreSaveEventErrorTitle,
                    error: err?.localizedDescription ?? StringConsts.genericError
                )
            } else {
                self.alert.value = self.createAlert(
                    title: "Event Saved!",
                    error: "Your event has been saved! Event Code: \(event.code)"
                )
            }
        }
    }
    
    private func handleInvalidEvent(status: EventCreationStatus) {
        if (status == .invalidUser) {
            self.alert.value = self.createAlert(
                title: StringConsts.eventCreationErrorTitle,
                error: StringConsts.invalidUser
            )
        } else if (status == .invalidDate) {
            self.alert.value = self.createAlert(
                title: StringConsts.eventCreationErrorTitle,
                error: StringConsts.invalidDate
            )
        }
    }
    
    private func createAlert(title: String, error: String) -> UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: error,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        return alert
    }
}

