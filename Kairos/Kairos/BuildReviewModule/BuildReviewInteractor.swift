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
  let userModel: UserLoginModel
  let reviewService: BuildReviewService
  let authService = UserRefreshToken()
  
  let defaults = UserDefaults.standard

  init (reviewModel: ReviewModel, spotModel: SpotModel, userModel: UserLoginModel, reviewService: BuildReviewService) {
    self.reviewModel = reviewModel
    self.spotModel = spotModel
    self.userModel = userModel
    self.reviewService = reviewService
  }
  
  func getIsReviewSuccess() -> Bool? {
    return reviewModel.isReviewSuccess()
  }
  
  func getSpotName() -> String {
    return spotModel.getSpotName()
  }
  
  func getSpotImage() -> UIImage? {
    return spotModel.getSpotImage()
  }
  
  func setNewReview(time: Int, light: Int, crowd: Int, chat: Int, completion: @escaping () -> Void) {
    reviewModel.newReview.spotID = spotModel.spot.spotID
    reviewModel.newReview.userID = userModel.user.userid
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
        self.reviewModel.newReview.success = true
        print("successreviewcall")
        success(nil)
      } failure: { (error) in
        self.reviewModel.newReview.success = false
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
        case .success:
          print("success 1")
          success(nil)
        case .failure(let error):
          if attempt == 2 {
            print("but how")
          } else if attempt < 2 {
            print("fail 1")
            self.refreshAuth() { (result) in
              if result == nil {
//                success(nil)
                self.submitReview(attempt: attempt + 1) { (result) in
                  success(nil)
                } failure: { (error) in
                  failure(error)
                }
              }
            }
          } else {
            print("should fail here...")
            failure(error)
          }
        }
      }
    }
  }
  // reviewCall makes network call, refreshes auth after one failure then makes network call again and sends a failure after the second failure
  
  
  func refreshAuth(completion: @escaping (RefreshResponseError?) -> Void) {
    do {
      userModel.user.refreshToken = defaults.string(forKey: "RefreshToken")
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      print("trying to refresh auth...")
      let data = try encoder.encode(userModel.user)
      authService.refresh(user: data) { (result) in
        switch result {
        case .success(let data):
          self.userModel.user.accessToken = data.accessToken
          self.defaults.set(data.accessToken, forKey: "AccessToken")
          print("made it")
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

