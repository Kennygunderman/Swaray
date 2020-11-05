//
//  RepoModule.swift
//  Swaray
//
//  Created by Kenny Gunderman on 11/23/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation
import FirebaseFirestore

private let db = Firestore.firestore()
let getEventRepo = Locator.bind(EventRepository.self) { EventRepository(database: db) }
