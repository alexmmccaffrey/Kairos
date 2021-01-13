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
  let userModel: UserLoginModel
  let reviewModel: ReviewModel
  let reviewCheckModel: ReviewCheckModel
  let service: SpotReviewService
  let buildReviewService: BuildReviewService
  let reviewCheckService: ReviewCheckService
  
//  let reviewCheckService: ReviewCheckService
  
  
  init (model: SpotModel, userModel: UserLoginModel, reviewModel: ReviewModel, reviewCheckModel: ReviewCheckModel, service: SpotReviewService, buildReviewService: BuildReviewService, reviewCheckService: ReviewCheckService) {
    self.model = model
    self.userModel = userModel
    self.reviewModel = reviewModel
    self.reviewCheckModel = reviewCheckModel
    self.service = service
    self.buildReviewService = buildReviewService
    self.reviewCheckService = reviewCheckService
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
  
  func getCrowdRating(crowd: Int) -> String {
    return self.model.getCrowdRating(crowd: crowd)
  }
  
  func getChatRating(chat: Int) -> String {
    return self.model.getChatRating(chat: chat)
  }
  
  func getLoggedInStatus() -> Bool? {
    return userModel.getLoggedInStatus()
  }
  
  func getIsReviewSuccess() -> Bool? {
    return reviewModel.isReviewSuccess()
  }
  
  func getReviewCheck(success: @escaping (ReviewCheckService.ReviewCheckError?) -> Void, failure: @escaping (Error) -> Void) {
    self.reviewCheckModel.spotID = self.model.spot.id
    self.reviewCheckModel.userID = self.userModel.user.userid
    do {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      let reviewCheckData = try encoder.encode(reviewCheckModel)
      reviewCheckService.userReviewCheck(data: reviewCheckData) { (result) in
        switch result {
        case .success:
          print("made it boiii")
          success(nil)
        case .failure(let error):
          print("fucked it up boii")
          failure(error)
        }
      }
    } catch {
      failure(error)
    }
    
    
  }
  
}
