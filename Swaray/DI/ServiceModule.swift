//
//  ServiceModule.swift
//  Swaray
//
//  Created by Kenny Gunderman on 9/19/19.
//  Copyright © 2019 Kenny Gunderman. All rights reserved.
//

import Foundation

let getAuthService = Locator.bind(AuthServiceInterface.self) { AuthService() }

let getSignInManager = Locator.bind(SignInManager.self) { SignInManager(authService: getAuthService()) }
