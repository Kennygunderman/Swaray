//
//  Locator.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/19/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//
// Service Locator pattern inspired by Lyft's "Opinionated Dependency Injection"
// link to video presentation here: https://www.youtube.com/watch?v=dA9rGQRwHGs
// Medium article implementing this pattern: https://noahgilmore.com/blog/swift-dependency-injection/

import Foundation

fileprivate typealias TypeInstantator = Any
enum Locator {
    private static var instantiators: [String: TypeInstantator] = [:]
    static var isTestEnvironment = false
    
    static func bind<T>(
        _ type: T.Type,
        instantiator: @escaping () -> T
        ) -> () -> T {
        instantiators[String(describing: type)] = instantiator
        return self.instance
    }
    
    private static func instance<T>() -> T {
        let key = String(describing: T.self)
        let instantiator = instantiators[key] as! () -> T
        return instantiator()
    }
}
