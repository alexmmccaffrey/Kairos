//
//  SpotSearchInteractor.swift
//  Kairos
//
//  Created by Alex McCaffrey on 7/27/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

class SpotSearchInteractor {
  let model: SpotModel
  let service: SpotNameSearch
  
  init(model: SpotModel, service: SpotNameSearch) {
    self.model = model
    self.service = service
  }
  
}
