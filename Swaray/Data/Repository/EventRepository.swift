//
//  EventRepository.swift
//  Swaray
//
//  Created by Kenny Gunderman on 11/23/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import FirebaseFirestore

class EventRepository {

    let database: Firestore
    init(database: Firestore) {
        self.database = database
    }
    
    /**
     Save's an event to the Database datasource.
     
     - parameters:
     event: The Event that will be saved to the data source.
     callback: Return's an Error if a problem occured when saving to
            remote data source. will always return Event when a
            response is recieved, regardless of an Error or not.
     */
    func save(event: Event, callback: @escaping (Event, Error?) -> Void) {
        database.collection("events").addDocument(data: event.dictionary) { err in
            callback(event, err)
        }
    }
}
