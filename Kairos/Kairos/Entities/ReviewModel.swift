//
//  ReviewModel.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/7/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation

final class ReviewModel {
  
  @Published var newReview = Review()
  
  func buildTimeReview(_ timeSelection: Int?) {
    newReview.time = timeSelection
    #if DEBUG
    print("newReview.time = \(newReview.time!)")
    #endif
  }
  
  func buildLightReview(_ lightSelection: Int?) {
    newReview.light = lightSelection
    #if DEBUG
    print("newReview.light = \(newReview.light!)")
    #endif
  }
  
  func buildCrowdReview(_ crowdSelection: Int?) {
    newReview.crowd = crowdSelection
    #if DEBUG
    print("newReview.crowd = \(newReview.crowd!)")
    #endif
  }
  
  func buildChatReview(_ chatSelection: Int?) {
    newReview.chat = chatSelection
    #if DEBUG
    print("newReview.chat = \(newReview.chat!)")
    #endif
  }

}

#if DEBUG
extension ReviewModel {
  static var sampleModel: ReviewModel {
    let model = ReviewModel()
    return model
  }
}
#endif
