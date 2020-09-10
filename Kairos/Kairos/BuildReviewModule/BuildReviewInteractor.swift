//
//  CreateReviewInteractor.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/9/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

class BuildReviewInteractor {
  let model: ReviewModel
  let service: BuildReviewService

  init (model: ReviewModel, service: BuildReviewService) {
    self.model = model
    self.service = service
  }

  func buildTimeReview(_ timeSelection: Int?) {
    model.buildTimeReview(timeSelection)
  }
    
  func buildLightReview(_ lightSelection: Int?) {
    model.buildLightReview(lightSelection)
  }
  
  func buildCrowdReview(_ crowdSelection: Int?) {
    model.buildCrowdReview(crowdSelection)
  }
  
  func buildChatReview(_ chatSelection: Int?) {
    model.buildChatReview(chatSelection)
  }
  
  func submitReview() {
    do {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      let jsonNewReview = try encoder.encode(model.newReview)
      service.postNewReview(jsonNewReview)
    } catch {
      print(error)
    }
  }
  
}

