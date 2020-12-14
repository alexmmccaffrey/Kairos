//
//  LoginRouter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 10/17/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

class LoginRouter {
  
  func makeHomeView(reviewModel: ReviewModel) -> some View {
    let imageDownloadService = ImageDownloadService()
    let locationService = UserLocationService()
    let searchService = SpotNameSearch()
    let spotFinderService = SpotFinderSearch()
    let presenter = HomePresenter(
      interactor: HomeInteractor(
        locationModel: LocationModel(),
        reviewModel: ReviewModel(),
        spotModel: SpotModel(
          spot: Spot()),
        userModel: UserLoginModel(),
        imageDownloadService: imageDownloadService,
        locationService: locationService,
        searchService: searchService,
        spotFinderService: spotFinderService))
    return HomeView(presenter: presenter)
  }
   
}
