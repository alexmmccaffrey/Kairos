//
//  SpotReviewRouter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/20/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

class SpotDetailRouter {
  
  func makeBuildReviewView(reviewModel: ReviewModel, spotModel: SpotModel, userModel: UserLoginModel, timePreference: DropdownOption) -> some View {
    let reviewService = BuildReviewService()
    let presenter = BuildReviewPresenter(
      interactor: BuildReviewInteractor(
        reviewModel: reviewModel,
        spotModel: spotModel,
        userModel: userModel,
        reviewService: reviewService),
      timePreference: timePreference)
    return BuildReviewView(presenter: presenter)
  }
  
}


