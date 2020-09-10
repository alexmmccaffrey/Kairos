//
//  SpotReviewInteractor.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/20/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

class SpotDetailInteractor {
  let model: SpotModel
  let service: SpotReviewService
  
  init (model: SpotModel, service: SpotReviewService) {
    self.model = model
    self.service = service
  }
  
  func getSpotDetails(_ id: Int, completion: @escaping (Spot) -> Void) {
    service.getSpotDetails(id) { (output) in
      completion(output)
    }
  }
}