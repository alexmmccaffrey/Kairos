//
//  SpotSearchRouter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 7/27/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

class SpotSearchRouter {
  
  func makeSpotDetailView(model: SpotModel, userModel: UserLoginModel, timePreference: DropdownOption) -> some View {
    let reviewModel = ReviewModel()
    let reviewCheckModel = ReviewCheckModel()
    let service = SpotReviewService()
    let buildReviewService = BuildReviewService()
    let reviewCheckService = ReviewCheckService()
    let presenter = SpotDetailPresenter(
      interactor: SpotDetailInteractor(
        model: model,
        userModel: userModel,
        reviewModel: reviewModel,
        reviewCheckModel: reviewCheckModel,
        service: service,
        buildReviewService: buildReviewService,
        reviewCheckService: reviewCheckService),
      timePreference: timePreference)
    return SpotDetailView(presenter: presenter)
  }
  
}
