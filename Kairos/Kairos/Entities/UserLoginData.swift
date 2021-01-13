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
  var isLoggedIn: Bool?
  var password: String?
  var refreshToken: String?
  var username: String?
  var userid: Int?
  
  init() {
    self.accessToken = UserDefaults.standard.string(forKey: "AccessToken")
    self.isLoggedIn = UserDefaults.standard.bool(forKey: "IsLoggedIn")
    self.refreshToken = UserDefaults.standard.string(forKey: "RefreshToken")
    self.userid = UserDefaults.standard.integer(forKey: "UserID")
    self.username = UserDefaults.standard.string(forKey: "Username")
  }
  
}
