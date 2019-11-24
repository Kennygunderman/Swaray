//
//  Event.swift
//  Swaray
//
//  Created by Kenny Gunderman on 11/23/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Event {
    var guid: String
    var code: String
    var createdBy: String
    var name: String
    var startDate: Timestamp
    
    var dictionary: [String: Any] {
        return [
            "code": code,
            "createdBy": createdBy,
            "guid": guid,
            "name": name,
            "startDate": startDate
        ]
    }
}
