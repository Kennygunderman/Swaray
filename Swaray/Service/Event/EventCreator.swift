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
 todo: docs
 */
enum EventCreationStatus {
    case success
    case invalidDate
    case invalidUser
}

/**
 todo: docs
 */
class EventCreator {
    let guidGenerator: GuidGenerator
    let dateFormatter: DateFormatter
    init(guidGenerator: GuidGenerator, dateFormatter: DateFormatter) {
        self.guidGenerator = guidGenerator
        self.dateFormatter = dateFormatter
    }
    
    /**
     todo: docs
     */
    func createEvent(name: String, date: String) -> (EventCreationStatus, Event?) {
        guard let date = dateFormatter.date(from: date) else {
            return (.invalidDate, nil)
        }
        
        return createEvent(name: name, date: date)
    }
    
    /**
     todo: add docs
     */
    func createEvent(name: String, date: Date) -> (EventCreationStatus, Event?) {
        guard let currentUser = Auth.auth().currentUser?.uid else {
            return (.invalidUser, nil)
        }
        
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
