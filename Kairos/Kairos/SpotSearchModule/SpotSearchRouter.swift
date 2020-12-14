//
//  SpotSearchRouter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 7/27/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

class SpotSearchRouter {
  
  func makeSpotDetailView(model: SpotModel, timePreference: DropdownOption) -> some View {
    let service = SpotReviewService()
    let presenter = SpotDetailPresenter(
      interactor: SpotDetailInteractor(
        model: model, service: service),
      timePreference: timePreference)
    return SpotDetailView(presenter: presenter)
  }
  
}
