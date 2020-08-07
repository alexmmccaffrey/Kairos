//
//  SpotReviewInteractor.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/20/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

class SpotReviewInteractor {
  let model: SpotModel
  let service: SpotReviewService
  
  init (model: SpotModel, service: SpotReviewService) {
    self.model = model
    self.service = service
  }
  
  func getSpotDetails(_ id: Int) {
    service.getSpotDetails(1) { (output) in
      self.model.SpotDetails.spotid = output.spotid
      self.model.SpotDetails.timerating = output.timerating
      self.model.SpotDetails.lightrating = output.lightrating
      self.model.SpotDetails.crowdrating = output.crowdrating
      self.model.SpotDetails.chatrating = output.chatrating
    }
  }
}
