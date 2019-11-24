//
//  GuidGenerator.swift
//  Swaray
//
//  Created by Kenny Gunderman on 11/23/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation

//todo: docs
class GuidGenerator {
    func generateGuid() -> String {
        return UUID().uuidString
    }
    
    func generate8CharGuid() -> String {
        return String(UUID().uuidString.prefix(8))
    }
}
