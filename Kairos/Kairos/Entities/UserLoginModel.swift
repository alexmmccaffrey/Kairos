//
//  UserLoginModel.swift
//  Kairos
//
//  Created by Alex McCaffrey on 10/10/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

class UserLoginModel {
  
  @Published var user = UserLoginData()
  
  
  func getLoggedInStatus() -> Bool {
    return user.isLoggedIn ?? false
  }
  
  func logout() {
    user.isLoggedIn = false
    user.email = nil
    user.accessToken = nil
    user.refreshToken = nil
    user.password = nil
    user.userid = nil
    user.username = nil
  }
  
  func getUserName() -> String {
    return user.username ?? "N/a"
  }

}

//#if DEBUG
extension UserLoginModel {
  static var sampleModel: UserLoginModel {
    let model = UserLoginModel()
    return model
  }
}
//#endif
