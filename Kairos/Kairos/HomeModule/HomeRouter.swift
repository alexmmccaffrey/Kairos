//
//  HomeRouter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/7/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

class HomeRouter {
  
  func makeBuildReviewView(model: ReviewModel) -> some View {
    let service = BuildReviewService()
    let presenter = BuildReviewPresenter(
      interactor: BuildReviewInteractor(
        model: model, service: service))
    return BuildReviewView(presenter: presenter)
  }
  
  func makeSpotDetailView(model: SpotModel) -> some View {
    let service = SpotReviewService()
    let presenter = SpotDetailPresenter(
      interactor: SpotDetailInteractor(
        model: model, service: service))
    return SpotDetailView(presenter: presenter)
  }
  
  func makeSpotSearchModule(spotModel: SpotModel) -> some View {
    let service = SpotNameSearch()
    
    let presenter = SpotSearchPresenter(
      interactor: SpotSearchInteractor(spotModel: spotModel, service: service)
    )
    return SpotSearchView(presenter: presenter)
  }
  
//  func makeDateCriteriaModule() {
//
//  }
  
//  func makeDateCriteriaView() -> some View {
//    
//  }
  
}
