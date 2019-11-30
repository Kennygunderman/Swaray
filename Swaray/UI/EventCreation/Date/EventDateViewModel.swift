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
    let creationError = Observable<String?>("")
    let eventSaveError = Observable<String?>("")
      
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
                /**
                 post error
                 */
            } else {
                /**
                 post success
                 */
                print("event saved! \(event.code)")
            }
        }
    }
    
    private func handleInvalidEvent(status: EventCreationStatus) {
        if (status == .invalidUser) {
            /**
             post invalid user msg to user
            */
        } else if (status == .invalidDate) {
            /**
            post invalid date msg to user
            */
        }
    }
}

