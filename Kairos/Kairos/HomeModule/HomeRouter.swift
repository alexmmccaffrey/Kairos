//
//  HomeRouter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 6/7/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

class HomeRouter {
  
  func makeSpotSearchModule(spotModel: SpotModel, userModel: UserLoginModel, timePreference: DropdownOption) -> some View {
    let service = SpotNameSearch()
    let presenter = SpotSearchPresenter(
      interactor: SpotSearchInteractor(
        spotModel: spotModel,
        userModel: userModel,
        service: service),
      timePreference: timePreference
    )
    return SpotSearchView(presenter: presenter)
  }
  
  func makeLoginModule(userModel: UserLoginModel) -> some View {
    let loginService = UserLoginService()
    let signUpService = UserSignUpService()
    let presenter = LoginPresenter(
      interactor: LoginInteractor(
        loginService: loginService,
        signUpService: signUpService,
        userModel: userModel
      ), isFromHome: true)
    return LoginView(presenter: presenter)
  }
  
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
  
  func makeDateCriteriaView(model: SpotModel) -> some View {
    let searchService = SpotFinderSearch()
    let presenter = DateCriteriaPresenter(
      interactor: DateCriteriaInteractor(model: model, searchService: searchService)
    )
    return DateCriteraView(presenter: presenter)
  }
  
}
