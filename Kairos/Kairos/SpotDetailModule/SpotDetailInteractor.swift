//
//  SpotReviewInteractor.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/20/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation
import SwiftUI

class SpotDetailInteractor: ObservableObject {
  let model: SpotModel
  let service: SpotReviewService
  
  
  init (model: SpotModel, service: SpotReviewService) {
    self.model = model
    self.service = service
  }
  
  func getSpotName() -> String {
    return self.model.getSpotName()
  }
  
  func getSpotAddress() -> String {
    return self.model.getSpotAddress()
  }
  
  func getSpotImage() -> UIImage? {
    return self.model.getSpotImage()
  }
  
  func getLightRating(time: Int) -> String {
    return self.model.getLightRating(time: time)
  }
  
  func getCrowdRating(time: Int) -> String {
    return self.model.getCrowdRating(time: time)
  }
  
  func getChatRating(time: Int) -> String {
    return self.model.getChatRating(time: time)
  }
  
}
