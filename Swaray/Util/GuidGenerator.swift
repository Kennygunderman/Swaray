//
//  GuidGenerator.swift
//  Swaray
//
//  Created by Kenny Gunderman on 11/23/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation

/**
 Class responsible for generating Guid's used to create Objects throughout
 Firebase Schema.
 */
class GuidGenerator {
    
    // Create's a standard GUID
    func generateGuid() -> String {
        return UUID().uuidString
    }
    
    // Create's an Eight character GUID
    func generate8CharGuid() -> String {
        return String(UUID().uuidString.prefix(8))
    }
}
