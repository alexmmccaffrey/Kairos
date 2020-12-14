//
//  CreateReviewInteractor.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/9/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import Foundation
import SwiftUI

class BuildReviewInteractor {
  let reviewModel: ReviewModel
  let spotModel: SpotModel
  let reviewService: BuildReviewService
  let authService = UserRefreshToken()
  let userLoginModel = UserLoginModel()

  init (reviewModel: ReviewModel, spotModel: SpotModel, reviewService: BuildReviewService) {
    self.reviewModel = reviewModel
    self.spotModel = spotModel
    self.reviewService = reviewService
  }
  
  let defaults = UserDefaults.standard
  
  func getSpotName() -> String {
    return spotModel.getSpotName()
  }
  
  func getSpotImage() -> UIImage? {
    return spotModel.getSpotImage()
  }
  
  func setNewReview(time: Int, light: Int, crowd: Int, chat: Int, completion: @escaping () -> Void) {
    reviewModel.newReview.spotID = spotModel.spot.spotID
    reviewModel.newReview.time = time
    reviewModel.newReview.light = light
    reviewModel.newReview.crowd = crowd
    reviewModel.newReview.chat = chat
    completion()
  }
  
  func submitReview(attempt: Int, success: @escaping (RefreshResponseError?) -> Void, failure: @escaping (Error?) -> Void) {
    do {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      print(reviewModel.newReview)
      let jsonReview = try encoder.encode(reviewModel.newReview)
      reviewCall(attempt: attempt, json: jsonReview) { (result) in
        success(nil)
      } failure: { (error) in
        failure(error)
      }
    } catch {
      failure(error)
    }
  }
  
// submitReview will encode JSON for ReviewModel and call the reviewCall function
  
  
  func reviewCall(attempt: Int, json: Data, success: @escaping (RefreshResponseError?) -> Void, failure: @escaping (Error?) -> Void) {
    if attempt <= 2 {
      reviewService.postNewReview(data: json, accessToken: defaults.string(forKey: "AccessToken") ?? "") { (result) in
        switch result {
        case .success(_):
          success(nil)
        case .failure(let error):
          if attempt < 2 {
            self.refreshAuth() { (result) in
              if result == nil {
                success(nil)
                self.submitReview(attempt: attempt + 1) { (result) in
                  success(nil)
                } failure: { (error) in
                  failure(error)
                }
              }
            }
          } else {
            failure(error)
          }
        }
      }
    }
  }
  // reviewCall makes network call, refreshes auth after one failure then makes network call again and sends a failure after the second failure
  
  
  func refreshAuth(completion: @escaping (RefreshResponseError?) -> Void) {
    do {
      userLoginModel.user.refreshToken = defaults.string(forKey: "RefreshToken")
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      print("trying to refresh auth...")
      let data = try encoder.encode(userLoginModel.user)
      authService.refresh(user: data) { (result) in
        switch result {
        case .success(let data):
          self.userLoginModel.user.accessToken = data.accessToken
          self.defaults.set(data.accessToken, forKey: "AccessToken")
          print(data.accessToken)
          completion(nil)
        case .failure(let error):
          completion(error)
        }
      }
    } catch let error {
      print(error)
    }
  }
  // Refreshes accessToken from backend if current token is expired
  
}

