//
//  UtilModule.swift
//  Swaray
//
//  Created by Kenny Gunderman on 11/10/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation

fileprivate let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "M/d/yyyy"
    return formatter
}()

let getDateFormatter = Locator.bind(DateFormatter.self) { dateFormatter }
let getGuidGenerator = Locator.bind(GuidGenerator.self) { GuidGenerator() }
