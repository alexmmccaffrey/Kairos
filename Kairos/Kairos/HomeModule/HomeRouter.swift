//
//  HomeRouter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/7/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

class HomeRouter {
  
  func makeSpotDetailView(model: SpotModel) -> some View {
    let service = SpotReviewService()
    let presenter = SpotDetailPresenter(
      interactor: SpotDetailInteractor(
        model: model, service: service))
    return SpotDetailView(presenter: presenter)
  }
  
  func makeSpotSearchModule(spotModel: SpotModel, timePreference: DropdownOption) -> some View {
    let service = SpotNameSearch()
    let presenter = SpotSearchPresenter(
      interactor: SpotSearchInteractor(spotModel: spotModel, service: service),
      timePreference: timePreference
    )
    return SpotSearchView(presenter: presenter)
  }
  
  func makeDateCriteriaView(model: SpotModel) -> some View {
    let searchService = SpotFinderSearch()
    let presenter = DateCriteriaPresenter(
      interactor: DateCriteriaInteractor(model: model, searchService: searchService)
    )
    return DateCriteraView(presenter: presenter)
  }
  
}
