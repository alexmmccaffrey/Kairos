//
//  UserLoginData.swift
//  Kairos
//
//  Created by Alex McCaffrey on 10/10/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

struct UserLoginData: Codable {
  
  var accessToken: String?
  var email: String?
  var refreshToken: String?
  var password: String?
  var username: String?
  
  init() {}
  
}
