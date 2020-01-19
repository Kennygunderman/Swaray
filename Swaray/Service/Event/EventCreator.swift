//
//  EventCreation.swift
//  Swaray
//
//  Created by Kenny Gunderman on 11/23/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import Firebase


/**
 This Enum is used in correlation with the EventCreator for returning
 different creation `statuses` when an Event is being constructed.
 
 @see Event
 */
enum EventCreationStatus {
    case success
    case invalidDate
    case invalidUser
}

/**
 EventCreator is responsible for constructing an event & handling all
 validation paramaters necessary for creating an Event such as user, and
 date validation.
 
 TODO: turn this into a Builder in the future for when we have multiple params
 to create an Event. This will help with passing the Builder around controllers.
 */

class EventCreator {
    let guidGenerator: GuidGenerator
    let dateFormatter: DateFormatter
    init(guidGenerator: GuidGenerator, dateFormatter: DateFormatter) {
        self.guidGenerator = guidGenerator
        self.dateFormatter = dateFormatter
    }
    
    /**
     Creates an Event with a name & string paramater.
     
     - parameters:
     - name: The name of the Event
     - date: The start date of the Event in form of a String. If the date isn't
            parsed correctly, then EventCreationStatus.invalid date will be returned.
     
     - return: EventCreationStatus & Event. If there was an error parsing the string
            provided date, a nil Event will be returned.
     */
    func createEvent(name: String, date: String) -> (EventCreationStatus, Event?) {
        guard let date = dateFormatter.date(from: date) else {
            return (.invalidDate, nil)
        }
        
        return createEvent(name: name, date: date)
    }
    
    /**
     Creates an Event with a name & date.
     
     - parameters:
     - name: The name of the Event.
     - date: The start date of the Event.
     
     - return: EventCreationStatus & Event. If there was an error validating the
            current Auth user from Firebase a EventCreationStatus.invalidUser will
            be returned with a nil Event. If all validation passes, an Event will
            be returned with a EventCreationStatus.success.
     */
    func createEvent(name: String, date: Date) -> (EventCreationStatus, Event?) {
        guard let currentUser = Auth.auth().currentUser?.uid else {
            return (.invalidUser, nil)
        }
        
        return (.invalidUser, nil)
        
        let event = Event(
            guid: guidGenerator.generateGuid(),
            code: guidGenerator.generate8CharGuid(),
            createdBy: currentUser,
            name: name,
            startDate: Timestamp(date: date)
        )
        
        return (.success, event)
    }
}
