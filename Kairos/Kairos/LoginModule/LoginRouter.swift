//
//  LoginRouter.swift
//  Kairos
//
//  Created by Alex McCaffrey on 10/17/20.
//  Copyright © 2020 Alex McCaffrey. All rights reserved.
//

import SwiftUI

class LoginRouter {
  
  func makeHomeView(reviewModel: ReviewModel, userModel: UserLoginModel) -> some View {
    let spotModel = SpotModel(spot: Spot())
    let recentlyReviewedSpotModel = SpotModel(spot: Spot())
    let nearbySpotModel = SpotModel(spot: Spot())
    let imageDownloadService = ImageDownloadService()
    let locationService = UserLocationService()
    let searchService = SpotNameSearch()
    let spotFinderService = SpotFinderSearch()
    let nearbySpotService = NearbySpots()
    let recentlyReviewedService = RecentlyReviewedSpots()
    let presenter = HomePresenter(
      interactor: HomeInteractor(
        locationModel: LocationModel(),
        reviewModel: reviewModel,
        spotModel: spotModel,
        recentlyReviewedSpotModel: recentlyReviewedSpotModel,
        nearbySpotModel: nearbySpotModel,
        userModel: userModel,
        imageDownloadService: imageDownloadService,
        locationService: locationService,
        searchService: searchService,
        spotFinderService: spotFinderService,
        nearbySpotService: nearbySpotService,
        recentlyReviewedService: recentlyReviewedService))
    return HomeView(presenter: presenter)
  }
   
}
