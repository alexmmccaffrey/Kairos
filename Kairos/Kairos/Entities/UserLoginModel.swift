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

}

#if DEBUG
extension UserLoginModel {
  static var sampleModel: UserLoginModel {
    let model = UserLoginModel()
    return model
  }
}
#endif
