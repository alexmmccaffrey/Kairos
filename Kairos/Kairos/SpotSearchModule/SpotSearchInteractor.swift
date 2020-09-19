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
  let service: SpotNameSearch
  
  init(spotModel: SpotModel, service: SpotNameSearch) {
    self.spotModel = spotModel
    self.service = service
  }
  
}
