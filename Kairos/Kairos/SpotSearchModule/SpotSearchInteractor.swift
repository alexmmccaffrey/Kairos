//
//  SpotSearchInteractor.swift
//  Kairos
//
//  Created by Alex McCaffrey on 7/27/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

class SpotSearchInteractor {
  let spotModel: SpotModel
  let userModel: UserLoginModel
  let service: SpotNameSearch
  
  init(spotModel: SpotModel, userModel: UserLoginModel, service: SpotNameSearch) {
    self.spotModel = spotModel
    self.userModel = userModel
    self.service = service
  }
  
}
